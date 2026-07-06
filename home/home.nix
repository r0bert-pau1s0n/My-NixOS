# ~/nix/home/home.nix
{ config, pkgs, inputs, ... }:

{
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
