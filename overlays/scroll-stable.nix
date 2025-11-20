final: prev: {
  sway-unwrapped = prev.sway-unwrapped.overrideAttrs (old: {
    src = prev.fetchFromGitHub {
      owner = "dawsers";
      repo = "scroll";
      rev = "1.11.8";
      hash = "sha256-SEhm7FKzAVNLuId3ap1EvQkQmbp+jP/G+WnIDSmedXQ=";
    };

    # quick & dirty fix to avoid problems with incompatible patches
    # (they're not necessary for core functionality anyway)
    patches = [];

    PKG_CONFIG_PATH = "${prev.wlroots_0_19}/lib/pkgconfig";
    buildInputs = old.buildInputs ++ [
      prev.lua54Packages.lua
    ];

    # expose scroll session to session managers
    passthru.providedSessions = [ "scroll" ];
  });
}
