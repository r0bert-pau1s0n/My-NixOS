{ pkgs, ... }:

{
  home = {
    username = "robert";
    homeDirectory = "/home/robert";
    stateVersion = "26.05";

    # Курсор для GTK и системы
    pointerCursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
      gtk.enable = true;
    };
  };

  imports = [
    ./packages.nix
    ./bundle.nix
  ];

  programs.home-manager.enable = true;
}
