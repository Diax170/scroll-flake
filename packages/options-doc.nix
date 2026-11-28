{
  pkgs,
  lib,
  runCommand,
  nixosOptionsDoc,

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
  optionsDoc = nixosOptionsDoc { inherit (cleanEval) options; };
in
runCommand "OPTIONS.md" { } ''
  cp ${optionsDoc.optionsCommonMark} $out
''
