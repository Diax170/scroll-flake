{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.wayland.windowManager.scroll.scrollnag;

  iniFormat = pkgs.formats.ini { };

  confFormat =
    with lib.types;
    let
      confAtom =
        nullOr (oneOf [
          bool
          int
          float
          str
        ])
        // {
          description = "Scrollnag config atom (null, bool, int, float, str)";
        };
    in
    attrsOf confAtom;
in
{
  # TODO: add scroll-specific things
  meta.maintainers = [ ];

  options = {
    wayland.windowManager.scroll.scrollnag = {
      enable = lib.mkEnableOption "configuration of scrollnag, a lightweight error bar for scroll";

      settings = lib.mkOption {
        type = lib.types.attrsOf confFormat;
        default = { };
        description = ''
          Configuration written to
          {file}`$XDG_CONFIG_HOME/scrollnag/config`.

          See
          {manpage}`scrollnag(5)`
          for a list of available options and an example configuration.
          Note, configurations declared under `<config>`
          will override the default type values of scrollnag.
        '';
        example = lib.literalExpression ''
          {
            "<config>" = {
              edge = "bottom";
              font = "Dina 12";
            };

            green = {
              edge = "top";
              background = "00AA00";
              text = "FFFFFF";
              button-background = "00CC00";
              message-padding = 10;
            };
          }
        '';
      };
    };
  };

  config = lib.mkIf cfg.enable {
    assertions = [
      (lib.hm.assertions.assertPlatform "wayland.windowManager.scroll.scrollnag" pkgs lib.platforms.linux)
    ];

    xdg.configFile."scrollnag/config" = lib.mkIf (cfg.settings != { }) {
      source = iniFormat.generate "scrollnag.conf" cfg.settings;
    };
  };
}
