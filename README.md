<p align="center"><img src="logo.png" height=256></p>
<h1 align="center">scroll-flake</h1>

<p align="center">
  <img alt="GitHub Repo stars" src="https://img.shields.io/github/stars/Diax170/scroll-flake?style=flat">
  <img alt="GitHub last commit (branch)" src="https://img.shields.io/github/last-commit/Diax170/scroll-flake/master?style=flat&label=last%20update">
</p>

> [!NOTE]
> This repository used to be maintained by @AsahiRocks. It's recently been archived, just at the time when I'm switching to NixOS (coincidence?). So I decided to try to fork off and keep this repo up to date by myself. More info [here](https://github.com/dawsers/scroll/discussions/236).

This flake contains NixOS packages & modules for [scroll](https://github.com/dawsers/scroll), which is a fork of Sway (an i3-compatible Wayland compositor) with a scrolling tiling layout.

This concept should be already familiar to users of PaperWM, Karousel, niri and other projects. If not, however, you can watch this great video by Brodie Robertson explaining it [here](https://www.youtube.com/watch?v=r0JUm77inIA).

## Installation
To get started, just simply add the repository to your flake inputs:

```nix
{
  inputs = {
    # ... other inputs

    scroll-flake = {
      url = "github:Diax170/scroll-flake";
      inputs.nixpkgs.follows = "nixpkgs"; # this assumes nixos unstable
    };
  };
  
  # ... rest of your flake
}
```

## NixOS Module
A NixOS module is available that provides an easy way to enable scroll, and additionally configure some basic options.

If you wish to use it, you need to first import the scroll-flake module in your NixOS configuration's flake:

```nix
{
  # ... rest of your flake

  outputs = inputs @ { self, nixpkgs, ... }: {
    # example host, replace with your own!
    nixosConfigurations.example = nixpkgs.lib.nixosSystem {
      modules = [
        inputs.scroll-flake.nixosModules.default

        # ... other modules
      ];

      specialArgs = {
        # Allows the configuration to import inputs
        inherit inputs;
      }
    };
  };
}
```

Now, you can use the scroll module anywhere in your configuration! Here's an example config that enables the git version of scroll alongside some other options:

```nix
{
  pkgs,
  inputs,
  ...
}:
{
  programs.scroll = {
    enable = true;
    package = inputs.scroll-flake.packages.${pkgs.stdenv.hostPlatform.system}.scroll-git;

    # Commands executed before scroll gets launched, see more examples here:
    # https://github.com/dawsers/scroll#environment-variables
    extraSessionCommands = ''
      # Tell QT, GDK and others to use the Wayland backend by default, X11 if not available
      export QT_QPA_PLATFORM="wayland;xcb"
      export GDK_BACKEND="wayland,x11"
      export SDL_VIDEODRIVER=wayland
      export CLUTTER_BACKEND=wayland

      # XDG desktop variables to set scroll as the desktop
      export XDG_CURRENT_DESKTOP=scroll
      export XDG_SESSION_TYPE=wayland
      export XDG_SESSION_DESKTOP=scroll

      # Configure Electron to use Wayland instead of X11
      export ELECTRON_OZONE_PLATFORM_HINT=wayland
    '';
  };

  # Enable Pipewire for screencasting and audio server
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };
}
```

## UWSM
Add the following snippet to your configuration to integrate scroll with the Universal Wayland Session Manager:

```nix
{
  # ...

  programs.uwsm = {
    enable = true;
    waylandCompositors = {
      scroll = {
        prettyName = "Scroll";
        comment = "Scroll compositor managed by UWSM";
        binPath = "/run/current-system/sw/bin/scroll";
      };
    };
  };

  # ...
}
```

This will install UWSM and create a desktop entry accessible by your display manager.

## Starting from command line

### Normally
```
$ scroll
```

### With UWSM
If you want to start Scroll with UWSM manually, use the `-F` flag or provide a full path to the `scroll` executable.

Correct:
- `uwsm start -F scroll` (recommended, enforces full path)
- `uwsm start /run/current-system/sw/bin/scroll`
- `uwsm start "$(which scroll)"`

Incorrect:
- `uwsm start scroll`
- `uwsm start scroll.desktop`

Don't run the desktop entry because it doesn't contain an absolute path (`Exec=scroll`), causing UWSM to fail.


## Customization
> [!NOTE]
> This flake automatically installs [some packages](modules/nixos.nix#L127), such as portals, but also programs like kitty or pulseaudio. If you don't want to use them, override the `programs.scroll.extraPackages` option with whatever packages you'd like to be installed instead. However, it's recommended to use the following de-bloating override which only installs portals:
> ```nix
> programs.scroll.extraPackages = with pkgs; [
>   xdg-desktop-portal
>   xdg-desktop-portal-gtk
>   xdg-desktop-portal-wlr
>   rofi # needed for the screen cast selector to work. Can be replaced with bemenu
> ];
> ```

To see all available options, you can reference the [module source](modules/nixos.nix) or Sway [NixOS module](https://mynixos.com/nixpkgs/options/programs.sway) from Nixpkgs, as they are both very similar.

> [!WARNING]
> Upon enabling the scroll module, some applications may take longer to start or fail entirely, most notably Waybar. This is not an issue exclusive to scroll, as it also seems to be happening to other Sway users on NixOS. To address this, you will need to manually add this line to the top of your configuration:
>
> `include /etc/scroll/config.d/*`
>
> If you wanna read more, refer to [this](https://github.com/Alexays/Waybar/issues/2675#issuecomment-3288118070) comment on a GitHub issue.

## Package

The input also exposes 3 package names, if you wish to install them manually:
- 📦 `default` — same as using "scroll-stable"
- 📦 `scroll-stable` — the latest tagged release of scroll (currently "1.12.8")
- 📦 `scroll-git` — the git (master branch) version of scroll, which gets automatically rebased daily (on UTC 0:00)

Using them is as simple as adding a normal package:

```nix
{
  pkgs,
  inputs,
  ...
}:
let
  system = pkgs.stdenv.hostPlatform.system;
in
{
  environment.systemPackages = [
    # scroll package (replace `default` with whatever package name above)
    inputs.scroll-flake.packages.${system}.default
  ];
}
```

## TODO
- [x] Add documentation on how to run with UWSM
- [ ] Generate documentation from the NixOS module
- [ ] Create a Home Manager module

## License
This project is licensed under the [MIT License](./LICENSE)
