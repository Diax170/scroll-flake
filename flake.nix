{
  description = "Nix flake for the Scroll Window Manager (based on Sway)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    scroll-stable = {
      url = "git+https://github.com/dawsers/scroll?ref=refs/tags/1.11.8";
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
      }).sway-unwrapped;

      "scroll-git" = (import nixpkgs {
        inherit system;
        overlays = [(import ./overlays/scroll-git.nix { inherit inputs; })];
      }).sway-unwrapped;

      default = self.packages.${system}."scroll-stable";
    });

    nixosModules.default = import ./modules/nixos.nix { inherit self; };
  };
}
