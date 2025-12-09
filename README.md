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
The NixOS module is still in testing, but you should be able to use it to enable scroll and configure some basic options.

Firstly, you need to import the scroll-flake module in your NixOS configuration's flake:

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

    # See a full list of recommended environment variables here:
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

    extraOptions = [
      "--verbose"
    ];

    # The module already preinstalls some useful packages. Setting this will overwrite them.
    extraPackages = with pkgs; [
      brightnessctl
      alacritty
      grim
      swaybg
      wmenu
      xdg-desktop-portal
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
    ];
  };

  # enable pipewire for screencasting and audio server
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };
}
```

## Package

The input also exposes 3 package names, if you wish to install them manually:
- 📦 `default` — same as using "scroll-stable"
- 📦 `scroll-stable` — the latest tagged release of scroll (currently "1.12.2")
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
