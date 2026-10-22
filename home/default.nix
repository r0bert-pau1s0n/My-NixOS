{ host, pkgs, ... }:

{
  imports = [
    ./packages.nix

    ./programs/niri/niri.nix
    ./programs/niri/niri-window-actions.nix
    ./programs/kitty/kitty.nix
    ./programs/noctalia/noctalia.nix
    ./programs/qbittorrent/qbittorrent.nix
    ./programs/zsh/zsh.nix
    ./programs/librewolf/librewolf.nix
    ./programs/portals/portals.nix
    ./programs/nvim/nvim.nix
    ./programs/yazi/yazi.nix
    ./programs/opencode/opencode.nix
    ./programs/tmux/tmux.nix
    ./programs/git/git.nix
    ./programs/cli-tools/cli-tools.nix

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
