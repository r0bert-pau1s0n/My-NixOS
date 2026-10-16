{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    # Пользовательские утилиты
    #yazi (установка через home-manager)
    btop
    fastfetch
    #zsh (установка через home-manager)
    
    # Инструменты разработки (нужны для nvim-treesitter и lazy.nvim)
    neovim
    (ansible.override { extraPackages = ps: with ps; [ boto3 docker kubernetes ]; })
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
    spotify 
    steam
  ];
}
