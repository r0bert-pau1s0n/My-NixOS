{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Пользовательские утилиты
    #yazi (установка через home-manager)
    btop
    fastfetch
    #zsh (установка через home-manager)

    # Инструменты разработки (нужны для nvim-treesitter и lazy.nvim)
    neovim
    (ansible.override {
      extraPackages =
        ps: with ps; [
          boto3
          docker
          kubernetes
        ];
    })
    gcc
    gnumake
    unzip
    opencode

    # Браузер
    ungoogled-chromium
    #librewolf (установка через home-manager)
    # qbittorrent ставится через home/programs/qbittorrent/qbittorrent.nix (обёртка темы)

    # Мессенджеры
    telegram-desktop
    vesktop
    spotify
    # Steam с Millennium (overlay в modules/common.nix) — для темы Noctalia
    millennium-steam
    # Запуск Windows-игр вне Steam (overlay в modules/common.nix)
    portproton

    # Утилиты, на которые ссылаются бинды niri и opener'ы yazi
    swaylock
    playerctl
    brightnessctl
    mpv
    vscode
  ];
}
