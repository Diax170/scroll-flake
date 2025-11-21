{ inputs, ... }:
final: prev: {
  sway-unwrapped = prev.sway-unwrapped.overrideAttrs (old: {
    src = inputs.scroll-stable;

    patches = [];

    nativeBuildInputs = old.nativeBuildInputs ++ (with prev; [
      glslang
      lcms
      hwdata
      libliftoff
    ]);

    buildInputs = old.buildInputs ++ (with prev; [
      lua54Packages.lua
      vulkan-loader
      xwayland
      seatd
      lcms
      libdisplay-info
      libxcb-render-util
      libxcb-errors
      libliftoff
      libgbm
    ]);
  });
}