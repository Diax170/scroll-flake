{
  lib,

  sway-unwrapped, # sway from nixpkgs which will be overridden
  json_c, # the old json_c from nixpkgs

  # dependencies
  glslang,
  hwdata,
  lua54Packages,
  vulkan-loader,
  xwayland,
  seatd,
  lcms,
  libdisplay-info,
  libxcb-render-util,
  libxcb-errors,
  libliftoff,
  libgbm,
  readline,

  src, # source of scroll, supplied on our own
  new-json_c, # the new json_c, supplied on our own
}:
sway-unwrapped.overrideAttrs (old: {
  inherit src;
  pname = "scroll-unwrapped";
  meta.mainProgram = "scroll";

  mesonFlags = old.mesonFlags ++ [
    "-Dc_args=-Wno-error=maybe-uninitialized"
  ];

  passthru.providedSessions = [ "scroll" ];
  patches = [ ];

  nativeBuildInputs = old.nativeBuildInputs ++ ([
    glslang
    lcms
    hwdata
    libliftoff
  ]);

  buildInputs = (lib.remove json_c old.buildInputs) ++ ([
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
    new-json_c
  ]);
})
