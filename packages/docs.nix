{
  lib,
  writeShellScriptBin,
  gnused,

  nixos-options-doc,
  home-manager-options-doc,
}:
writeShellScriptBin "docs" ''
  set -e
  mkdir -p docs/
  cp -f ${nixos-options-doc} docs/OS-OPTIONS.md
  cp -f ${home-manager-options-doc} docs/HM-OPTIONS.md
  chmod 644 docs/{OS,HM}-OPTIONS.md

  # Remove "Declared by" sections
  ${lib.getExe gnused} -i '/^\*Declared by:\*$/,/^[[:space:]]*$/d' docs/{OS,HM}-OPTIONS.md
''
