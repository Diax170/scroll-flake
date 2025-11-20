{
  self,
  ...
}:
{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.scroll;
in
{
  options.programs.scroll = {
    enable = lib.mkEnableOption ''
      scroll, a fork of the i3-compatible Wayland compositor 'Sway' with a scrolling tiling layout.
    '';

    package =
      lib.mkOption {
        type = lib.types.package;
        default = self.packages.${pkgs.stdenv.hostPlatform.system}.default;
        description = "The scroll package to use.";
      };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };
}