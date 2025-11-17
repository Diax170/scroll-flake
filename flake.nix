{
  description = "Nix flake for the Scroll Window Manager (based on Sway)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";
  in
  {
    packages.${system} = {
      "scroll-stable" = (import nixpkgs {
        inherit system;
        overlays = [(import ./overlay.nix)];
      }).sway-unwrapped;

      default = self.packages.${system}."scroll-stable";
    };
  };
}
