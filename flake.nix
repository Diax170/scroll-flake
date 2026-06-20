{
  description = "NixOS flake for scroll, a fork of Sway with a scrolling tiling layout";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    scroll-stable = {
      url = "git+https://github.com/dawsers/scroll?ref=refs/tags/1.12.15";
      flake = false;
    };

    scroll-git = {
      url = "git+https://github.com/dawsers/scroll?ref=master";
      flake = false;
    };
  };

  outputs = inputs@{ self, nixpkgs, ... }:
  let
    supportedSystems = [ "x86_64-linux" "aarch64-linux" ];
    forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    nixpkgsFor = forAllSystems (system: import nixpkgs { inherit system; });
  in
  {
    packages = forAllSystems (system:
    let
      scrollStablePkgs = (import nixpkgs {
        inherit system;
        overlays = [(import ./overlays/scroll-stable.nix { inherit inputs; })];
      });
      scrollGitPkgs = (import nixpkgs {
        inherit system;
        overlays = [(import ./overlays/scroll-git.nix { inherit inputs; })];
      });
    in
    {
      "scroll-stable" = scrollStablePkgs.sway;
      "scroll-stable-unwrapped" = scrollStablePkgs.sway-unwrapped;

      "scroll-git" = scrollGitPkgs.sway;
      "scroll-git-unwrapped" = scrollGitPkgs.sway-unwrapped;

      default = self.packages.${system}."scroll-stable";
    });

    devShells = forAllSystems (system:
    let
      pkgs = nixpkgsFor.${system};
      scroll-unwrapped = self.packages.${pkgs.system}.scroll-git-unwrapped;
    in
    {
      default = pkgs.mkShell {
        inputsFrom = [ scroll-unwrapped ];
        packages = with pkgs; [
          meson
          cmake
          ninja
          pkg-config
        ];
      };
    });

    nixosModules.default = import ./modules/nixos.nix { inherit self; };
  };
}
