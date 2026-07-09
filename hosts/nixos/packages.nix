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
    ouch
    bat
    neovim
    yazi
    zsh
    kitty
    
    # Сеть и Bluetooth
    bluez
    openssh
    
    # Wayland компоненты
    xwayland-satellite # Для запуска X11 приложений в Niri
    wl-clipboard
    cliphist
    satty
    polkit_gnome # Гуй для ввода пароля sudo
  ];
    # Правильная установка шрифтов
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
}
