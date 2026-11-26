{ pkgs, unwrapped }:
pkgs.sway.override { sway-unwrapped = unwrapped; }
