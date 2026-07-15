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
    gcc
    gnumake
    unzip

    # Браузер
    #librewolf (установка через home-manager)
    
    # V2rayN и ядра
    v2rayn
    xray
    sing-box

    # Мессенджеры
    telegram-desktop
    
    # Noctalia Shell (берем пакет из flake-инпута)
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
