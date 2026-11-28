# https://github.com/dawsers/scroll/issues/411
{ json_c, src }:
json_c.overrideAttrs (old: {
  inherit src;
  version = old.version + "-git";
})
