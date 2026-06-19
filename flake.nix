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

    # Need to retrieve both sway and sway-unwrapped
    # Using functions because of forAllSystems
    mkScrollStable = system: (import nixpkgs {
      inherit system;
      overlays = [(import ./overlays/scroll-stable.nix { inherit inputs; })];
    });
    mkScrollGit = system: (import nixpkgs {
      inherit system;
      overlays = [(import ./overlays/scroll-git.nix { inherit inputs; })];
    });
  in
  {
    packages = forAllSystems (system: {
      "scroll-stable" = (mkScrollStable system).sway;
      "scroll-git" = (mkScrollGit system).sway;
      default = self.packages.${system}."scroll-stable";
    });

    devShells = forAllSystems (system:
    let
      pkgs = nixpkgsFor.${system};
    in
    {
      default = pkgs.mkShell {
        # Need to select sway-unwrapped here because the wrapped sway package uses upstream build inputs
        inputsFrom = [ (mkScrollStable system).sway-unwrapped ];
        # Add some tools and libs to let Scroll compile
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
