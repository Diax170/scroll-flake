{ inputs, ... }:
final: prev: {
  sway-unwrapped = prev.sway-unwrapped.overrideAttrs (old: {
    src = inputs.scroll-git;
    meta.mainProgram = "scroll";

    # Prevent erroring on "may be uninitialized" warnings
    mesonFlags = old.mesonFlags ++ [
      "-Dc_args=-Wno-error=maybe-uninitialized"
    ];

    passthru.providedSessions = [ "scroll" ];
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
