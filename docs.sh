#!/usr/bin/env nix
#! nix shell nixpkgs#coreutils nixpkgs#nix nixpkgs#gnused nixpkgs#bash --command sh

# Regenerates the option docs

set -e

mkdir -p docs/

nix build .#nixos-options-doc
cp -f result docs/OS-OPTIONS.md
unlink result

nix build .#home-manager-options-doc
cp -f result docs/HM-OPTIONS.md
unlink result

chmod 644 docs/{OS,HM}-OPTIONS.md
# Remove "Declared by" sections
sed -i '/^\*Declared by:\*$/,/^[[:space:]]*$/d' docs/{OS,HM}-OPTIONS.md
