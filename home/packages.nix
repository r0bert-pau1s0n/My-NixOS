# ~/nix/home/packages.nix
{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    # Терминал и утилиты
    kitty
    btop
    git
    fzf
    zoxide
    
    # Мессенджеры и браузеры
    telegram-desktop
    librewolf
    
    # Noctalia Shell (берем пакет из flake-инпута)
    inputs.noctalia.packages.${pkgs.system}.default
    
    # Прочее
    yazi
  ];
}
