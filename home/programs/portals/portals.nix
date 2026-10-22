### Необходим для использования Yazi вкачестве проводника в librewolf
{ pkgs, ... }:

{
  # Скрипт-лаунчер для терминального портала
  home.packages = [
    (pkgs.writeShellScriptBin "portal-terminal" ''
      exec kitty --class file_chooser --override "map esc close_window" -- "$@"
    '')
  ];

  # Конфигурация xdg-desktop-portal-termfilechooser
  xdg.configFile."xdg-desktop-portal-termfilechooser/config".text = ''
    [filechooser]
    cmd = ${pkgs.writeShellScript "yazi-portal-wrapper.sh" ''
      export TERMCMD="portal-terminal"
      exec ${pkgs.xdg-desktop-portal-termfilechooser}/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh "$@"
    ''}
  '';
}
