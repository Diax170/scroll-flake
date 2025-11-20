{
  description = "Nix flake for the Scroll Window Manager (based on Sway)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
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
        overlays = [(import ./overlays/scroll-stable.nix)];
      }).sway-unwrapped;

      default = self.packages.${system}."scroll-stable";
    });

    nixosModules.default = import ./modules/nixos.nix { inherit self; };
  };
}
