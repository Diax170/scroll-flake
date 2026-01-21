# scroll-flake
This flake contains NixOS packages & modules for [scroll](https://github.com/dawsers/scroll), which is a fork of Sway (an i3-compatible Wayland compositor) with a scrolling tiling layout.

This concept should already be familliar to users of PaperWM, niri or other projects. If not, however, you can watch this great video by Brodie Robertson explaining the concept [here](https://www.youtube.com/watch?v=r0JUm77inIA).

## Installation
To get started, just simply add the repository to your flake inputs:

```nix
{
  inputs = {
    # ... other inputs

    scroll-flake = {
      url = "github:AsahiRocks/scroll-flake";
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

  outputs = inputs@{ self, nixpkgs, ... }: {
    # example host, replace with your own!
    nixosConfigurations.example = nixpkgs.lib.nixosSystem {
      modules = [
        inputs.scroll-flake.nixosModules.default

        # ... other modules
      ];
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

> [!NOTE]
> For the time being, there is no proper documentation being generated for the options.
> So, to see them all, you either need to read the source code for the NixOS module [here](./modules/nixos.nix),
> or, a simpler way is to just reference the Nixpkgs module for [Sway](https://mynixos.com/nixpkgs/options/programs.sway),
> since they're pretty similar.

> [!WARNING]
> Upon enabling the scroll module, some applications may take longer to start or fail entirely, most notably Waybar. This is not an issue exclusive to scroll, as it also seems to be happening to other Sway users on NixOS. To address this, you will need to manually add this line to the top of your configuration:
>
> `include /etc/scroll/config.d/*`
>
> If you wanna read more, refer to [this](https://github.com/Alexays/Waybar/issues/2675#issuecomment-3288118070) comment on a GitHub issue.

## Package

The input also exposes 3 package names, if you wish to install them manually:
- 📦 `default` — same as using "scroll-stable"
- 📦 `scroll-stable` — the latest tagged release of scroll (currently "1.12.4")
- 📦 `scroll-git` — the git (master branch) version of scroll, which gets automatically rebased daily

Using them is as simple as adding a normal package:

```nix
{
  pkgs,
  inputs,
  ...
}:
{
  environment.systemPackages = [
    # scroll package (replace `default` with whatever package name above)
    inputs.scroll-flake.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
```

## TODO
- [ ] Generate documentation from NixOS module
- [ ] Create a Home Manager module

## License
This project is licensed under the [MIT License](./LICENSE)
