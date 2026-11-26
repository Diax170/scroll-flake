{
  src,
  pkgs,
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
    old.buildInputs
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
    ]);
})
