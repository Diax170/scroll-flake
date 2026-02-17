{
  description = "NixOS flake for scroll, a fork of Sway with a scrolling tiling layout";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    scroll-stable = {
      url = "git+https://github.com/dawsers/scroll?ref=refs/tags/1.12.5";
      flake = false;
    };

    scroll-git = {
      url = "git+https://github.com/dawsers/scroll?ref=master";
      flake = false;
    };
  };

  outputs = inputs@{ self, nixpkgs, ... }:
  let
    eachSystem = nixpkgs.lib.genAttrs [
      "x86_64-linux"
      "aarch64-linux"
    ];
  in
  {
    packages = eachSystem (system: {
      "scroll-stable" = (import nixpkgs {
        inherit system;
        overlays = [(import ./overlays/scroll-stable.nix { inherit inputs; })];
      }).sway;

      "scroll-git" = (import nixpkgs {
        inherit system;
        overlays = [(import ./overlays/scroll-git.nix { inherit inputs; })];
      }).sway;

      default = self.packages.${system}."scroll-stable";
    });

    nixosModules.default = import ./modules/nixos.nix { inherit self; };
  };
}
