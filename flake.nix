{
  description = "NixOS flake for scroll, a fork of Sway with a scrolling tiling layout";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    json_c = {
      url = "github:json-c/json-c";
      flake = false;
    };

    scroll-stable = {
      url = "github:dawsers/scroll?ref=refs/tags/1.12.21";
      flake = false;
    };

    scroll-git = {
      url = "github:dawsers/scroll?ref=master";
      flake = false;
    };
  };

  outputs =
    inputs@{ self, nixpkgs, ... }:
    let
      inherit (nixpkgs) lib;
      forAllSystems =
        callback:
        lib.genAttrs [ "x86_64-linux" "aarch64-linux" ] (system: callback nixpkgs.legacyPackages.${system});
    in
    rec {
      packages = forAllSystems (
        pkgs:
        let
          new-json_c = pkgs.callPackage ./packages/json_c.nix { src = inputs.json_c; };

          # look at the package definitions in nixpkgs for a better view of what's happening
          mkScroll = src: pkgs.callPackage ./packages/scroll-unwrapped.nix { inherit src new-json_c; };

          wrap = unwrapped: pkgs.callPackage ./packages/scroll.nix { inherit unwrapped; };

          mkOptionsDoc = module: pkgs.callPackage ./packages/options-doc.nix { inherit module; };
        in
        rec {
          scroll-stable-unwrapped = mkScroll inputs.scroll-stable;
          scroll-stable = wrap scroll-stable-unwrapped;

          scroll-git-unwrapped = mkScroll inputs.scroll-git;
          scroll-git = wrap scroll-git-unwrapped;

          nixos-options-doc = mkOptionsDoc nixosModules.default;
          home-manager-options-doc = mkOptionsDoc homeModules.default;

          # Regenerate the docs: `nix run .#docs`
          docs = pkgs.callPackage ./packages/docs.nix { inherit nixos-options-doc home-manager-options-doc; };

          default = scroll-stable;
        }
      );

      devShells = forAllSystems (
        pkgs:
        let
          scroll-unwrapped = self.packages.${pkgs.stdenv.hostPlatform.system}.scroll-git-unwrapped;
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
        }
      );

      nixosModules.default = import ./modules/nixos.nix { inherit self; };
      homeModules.default = import ./modules/home/default.nix { inherit self; };
    };
}
