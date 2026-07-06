# ~/nix/hosts/nixos/packages.nix
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Системные утилиты
    git
    curl
    fd
    ripgrep
    zoxide
    fzf
    bat
    neovim
    
    # Сеть и Bluetooth
    bluez
    bluez-utils
    openssh
    
    # Wayland компоненты
    xwayland-satellite # Для запуска X11 приложений в Niri
    wl-clipboard
    cliphist
    satty
    polkit_gnome # Гуй для ввода пароля sudo
    
    # Шрифты (ставить лучше системно)
    nerd-fonts.jetbrains-mono
  ];
}
