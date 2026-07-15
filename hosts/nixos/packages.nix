{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Системные утилиты
    #git установка через home-manager
    curl
    fd
    ripgrep
    #zoxide установка через home-manager
    #fzf установка через home-manager
    ouch
    #bat установка через home-manager

    # Сеть и Bluetooth
    bluez
    openssh
    
    # Wayland компоненты
    xwayland-satellite # Для запуска X11 приложений в Niri
    wl-clipboard
    cliphist
    satty
    grim
    slurp
    polkit_gnome # Гуй для ввода пароля sudo
  ];
}
