# https://github.com/dawsers/scroll/issues/411
{ pkgs, src }:
pkgs.json_c.overrideAttrs (old: {
  inherit src;
  version = old.version + "-git";
})
