{
  cfg,
  pkgs,
  moduleName,
}:
{
  keybindings =
    if (cfg.package == null) then
      { }
    else
      import (pkgs.runCommand "sway-keybindings"
        {
          nativeBuildInputs = [ pkgs.python3 ];
        }
        ''
          python ${./keybindings.py} ${cfg.package}/etc/${moduleName}/config > $out
        ''
      ) { inherit cfg; };
}
