# ~/nix/home/bundle.nix
{ ... }:
{
  imports = [
    ./programs/niri.nix
    ./programs/kitty.nix
    ./programs/noctalia.nix
  ];
}
