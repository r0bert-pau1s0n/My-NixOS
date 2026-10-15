{ pkgs, ... }:

{
  home = {
    username = "robert";
    homeDirectory = "/home/robert";
    stateVersion = "26.05"; # ✅ Не менять!

    # Курсор для GTK и системы
    pointerCursor = {
      enable = true; # ← Добавлена эта строка (теперь обязательна)
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
