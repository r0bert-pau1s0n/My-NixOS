# ~/nix/home/home.nix
{ config, pkgs, inputs, ... }:

{
  # ДОБАВЛЕННАЯ СТРОКА: применяем оверлей niri-flake для Home Manager
  nixpkgs.overlays = [ inputs.niri-flake.overlays.niri ];

  home = {
    username = "robert";
    homeDirectory = "/home/robert";
    stateVersion = "26.05";
  };
  
  imports = [
    ./packages.nix
    ./bundle.nix
  ];

  programs.home-manager.enable = true;
}
