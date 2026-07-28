{ self, ... }:
{
  imports = [
    (import ./scroll.nix {
      inherit self;
    })
    (import ./scrollnag.nix)
  ];
}
