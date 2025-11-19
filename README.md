# scroll-flake
This flake contains NixOS packages for [scroll](https://github.com/dawsers/scroll), which is a fork of Sway (an i3-compatible Wayland compositor) with a scrollable tiling layout. 

This concept should already be familliar to users of PaperWM, niri or other projects.

## Usage
Just add this repository to your current flake, here's an example on how you could do that:

```nix
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    scroll-flake = {
      url = "git+https://codeberg.org/asahirocks/scroll-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  
  outputs = inputs@{ self, nixpkgs }: { # <-- make sure to expose inputs (the `inputs@` thing)...
    nixosConfigurations.example = nixpkgs.lib.nixosSystem {
      modules = [ ./configuration.nix ];
      specialArgs = { inherit inputs; }; # <-- ...and actually pass them to the modules
    };
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
  inputs, # <-- import the inputs here
  ...
}:
{
  environment.systemPackages = with pkgs; [
    inputs.scroll-flake.packages."x86_64-linux".default
    
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
- [ ] Create a NixOS/Home Manager module for enabling scroll alongside other packages.
- [ ] Add master package of scroll to the flake

## License
This project is licensed under the [MIT License](./LICENSE)
