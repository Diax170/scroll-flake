# scroll-flake
This flake contains NixOS packages for [scroll](https://github.com/dawsers/scroll), which is a fork of Sway (an i3-compatible Wayland compositor) with a scrollable tiling layout. 

This concept should already be familliar to users of PaperWM, niri or other projects.

## Usage
Add this repository to your current flake like so:

```nix
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # ... other inputs

    scroll-flake = {
      url = "git+https://codeberg.org/asahirocks/scroll-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  
  outputs = { self, nixpkgs, scroll-flake }: { # <-- make sure to add it here as well
    # ... rest of your flake
  }
}
```

The input will expose 2 new package names:
- `default` – same as using "scroll-stable"
- `scroll-stable` – the latest tagged release of scroll (currently "1.11.8")

Using them is as simple as adding a normal package:

```nix
{
  pkgs,
  scroll-flake, # <-- import the input here
  ...
}:
{
  environment.systemPackages = with pkgs; [
    scroll-flake.packages."x86_64-linux".default
    
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
- [ ] Use flake-utils to add other system architecture outputs
- [ ] Create a NixOS/Home Manager module for enabling scroll alongside other packages.
- [ ] Add master package of scroll to the flake