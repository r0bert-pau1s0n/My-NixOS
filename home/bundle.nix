# ~/nix/home/bundle.nix
{ ... }:
{
  imports = [
    ./programs/niri.nix
    ./programs/kitty.nix
    ./programs/noctalia.nix
    ./programs/zsh.nix
    ./programs/librewolf.nix
  ];
}
