{ config, pkgs, inputs, ... }:

{
  nixpkgs.overlays = [ inputs.niri-flake.overlays.niri ];

  home = {
    username = "robert";
    homeDirectory = "/home/robert";
    stateVersion = "26.05";
    
    # === НАСТРОЙКА КУРСОРОВ ДЛЯ GTK И СИСТЕМЫ ===
    pointerCursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
      gtk.enable = true;
      # x11.enable = true; # Раскомментируйте, если используете xwayland-satellite
    };
  };
  
  imports = [
    ./packages.nix
    ./bundle.nix
  ];

  programs.home-manager.enable = true;
}
