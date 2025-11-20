{ inputs, ... }:
final: prev: {
  sway-unwrapped = prev.sway-unwrapped.overrideAttrs (old: {
    src = inputs.scroll-stable;

    # quick & dirty fix to avoid problems with incompatible patches
    # (they're not necessary for core functionality anyway)
    patches = [];

    PKG_CONFIG_PATH = "${prev.wlroots_0_19}/lib/pkgconfig";
    buildInputs = old.buildInputs ++ [
      prev.lua54Packages.lua
    ];
  });
}
