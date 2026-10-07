{
  pkgs,
  lib ? pkgs.lib,
  module,
}:
let
  eval = lib.evalModules {
    specialArgs = {
      inherit pkgs lib;
      modulesPath = pkgs.path + /nixos/modules;
    };
    modules = [
      { _module.check = false; }
      module
    ];
  };
  cleanEval = lib.filterAttrsRecursive (n: v: n != "_module") eval;
  optionsDoc = pkgs.nixosOptionsDoc { inherit (cleanEval) options; };
in
pkgs.runCommand "OPTIONS.md" { } ''
  cp ${optionsDoc.optionsCommonMark} $out
''
