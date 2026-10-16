{ host, pkgs, ... }:

{
  imports = [
    ./packages.nix

    ./programs/niri.nix
    ./programs/kitty.nix
    ./programs/noctalia.nix
    ./programs/zsh.nix
    ./programs/librewolf.nix
    ./programs/v2rayn.nix
    ./programs/portals.nix
    ./programs/nvim/nvim.nix
    ./programs/yazi.nix
    ./programs/opencode.nix
    ./programs/tmux.nix
    ./programs/git.nix
    ./programs/cli-tools.nix

    ./wallpapers/wallpapers.nix

    # Host-специфичные настройки пользовательской среды
    (../hosts + "/${host}/home.nix")
  ];

  home = {
    username = "robert";
    homeDirectory = "/home/robert";
    stateVersion = "26.05"; # НЕ менять

    # Курсор для GTK и системы
    pointerCursor = {
      enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
      gtk.enable = true;
    };
  };

  programs.home-manager.enable = true;
}
