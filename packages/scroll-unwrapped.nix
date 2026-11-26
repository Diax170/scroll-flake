{
  src,
  pkgs,
  lib ? pkgs.lib,
  json_c,
  ...
}:
pkgs.sway-unwrapped.overrideAttrs (old: {
  inherit src;
  pname = "scroll-unwrapped";
  meta.mainProgram = "scroll";

  mesonFlags = old.mesonFlags ++ [
    "-Dc_args=-Wno-error=maybe-uninitialized"
  ];

  passthru.providedSessions = [ "scroll" ];
  patches = [ ];

  nativeBuildInputs =
    old.nativeBuildInputs
    ++ (with pkgs; [
      glslang
      lcms
      hwdata
      libliftoff
    ]);

  buildInputs =
    (lib.remove pkgs.json_c old.buildInputs)
    ++ (with pkgs; [
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
      readline
      json_c
    ]);
})
