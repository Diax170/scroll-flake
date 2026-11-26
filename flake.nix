{
  description = "NixOS flake for scroll, a fork of Sway with a scrolling tiling layout";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

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
      forAllSystems =
        callback:
        nixpkgs.lib.genAttrs [ "x86_64-linux" "aarch64-linux" ] (
          system: callback nixpkgs.legacyPackages.${system}
        );
    in
    rec {
      packages = forAllSystems (
        pkgs:
        let
          # look at the package definitions in nixpkgs for a better view of what's happening
          mkScroll = src: import ./packages/scroll-unwrapped.nix { inherit pkgs src; };

          wrap = unwrapped: import ./packages/scroll.nix { inherit pkgs unwrapped; };

          mkOptionsDoc = module: import ./packages/options-doc.nix { inherit pkgs module; };
        in
        rec {
          scroll-stable-unwrapped = mkScroll inputs.scroll-stable;
          scroll-stable = wrap scroll-stable-unwrapped;

          scroll-git-unwrapped = mkScroll inputs.scroll-git;
          scroll-git = wrap scroll-git-unwrapped;

          nixos-options-doc = mkOptionsDoc nixosModules.default;
          home-manager-options-doc = mkOptionsDoc homeModules.default;

          # Regenerate the docs: `nix run .#docs`
          docs = pkgs.writeShellScriptBin "docs" ''
            set -e
            mkdir -p docs/
            cp -f ${nixos-options-doc} docs/OS-OPTIONS.md
            cp -f ${home-manager-options-doc} docs/HM-OPTIONS.md
            chmod 644 docs/{OS,HM}-OPTIONS.md

            # Remove "Declared by" sections
            ${pkgs.lib.getExe pkgs.gnused} -i '/^\*Declared by:\*$/,/^[[:space:]]*$/d' docs/{OS,HM}-OPTIONS.md
          '';

          default = self.packages.${pkgs.stdenv.hostPlatform.system}.scroll-stable;
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
