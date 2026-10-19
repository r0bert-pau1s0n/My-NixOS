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
    #librewolf (установка через home-manager)
    qbittorrent

    # V2rayN и ядра
    v2rayn
    xray
    sing-box

    # Мессенджеры
    telegram-desktop
    vesktop
    spotify
    # Steam с Millennium (overlay в modules/common.nix) — для темы Noctalia
    millennium-steam
    # Запуск Windows-игр вне Steam (overlay в modules/common.nix)
    portproton
  ];
}
