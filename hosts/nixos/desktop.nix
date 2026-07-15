{ pkgs, ... }:

{
  # Niri compositor (системный уровень: сессия, dbus)
  # https://github.com/sodiboo/niri-flake
  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
  };

  # XDG Desktop Portals
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
      xdg-desktop-portal-termfilechooser  # Терминальный выбор файлов
    ];

    config = {
      common = {
        default = [ "gtk" "gnome" ];
        "org.freedesktop.impl.portal.FileChooser" = [ "termfilechooser" ];
      };
    };
  };

  security.polkit.enable = true;
  programs.dconf.enable = true;
}
