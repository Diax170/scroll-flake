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
The NixOS module is still a work-in-progress, but for now you can use it to easily install the scroll package on your system.

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

Now, you can use the scroll module anywhere in your configuration! Here's an example config that enables the git version of scroll:

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
  };
}
```

## Package

The input also exposes 3 package names, if you wish to install them manually:
- 📦 `default` — same as using "scroll-stable"
- 📦 `scroll-stable` — the latest tagged release of scroll (currently "1.12")
- 📦 `scroll-git` — the git (master branch) version of scroll, which gets automatically rebased daily

Using them is as simple as adding a normal package:

```nix
{
  pkgs,
  inputs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    # scroll package (replace `default` with whatever package name above)
    inputs.scroll-flake.packages.${pkgs.stdenv.hostPlatform.system}.default
    
    # you may want to grab some extra goodies
    kitty
    wmenu
    swaybg
    swayidle
    swaylock
    grim
    brightnessctl
    pulseaudio
  ];
}
```

## TODO
- [ ] Finish the NixOS module
  - [ ] Wrap the scroll packages similarily to Sway in Nixpkgs
  - [ ] Add rest of the options
- [ ] Create a Home Manager module

## License
This project is licensed under the [MIT License](./LICENSE)
