# ~/nix/home/packages.nix
{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    # Мессенджеры и браузеры
    telegram-desktop
    
    # Noctalia Shell (берем пакет из flake-инпута)
    inputs.noctalia.packages.${pkgs.system}.default
    
    # Прочее
    v2rayn
    xray
    sing-box

    # Создаем отдельный скрипт-лаунчер для терминала портала
    (pkgs.writeShellScriptBin "portal-terminal" ''
      exec kitty --class file_chooser --override "map esc close_window" -- "$@"
    '')
  ];

  xdg.dataFile."v2rayN/bin/xray/xray".source = "${pkgs.xray}/bin/xray";
  xdg.dataFile."v2rayN/bin/sing_box/sing-box".source = "${pkgs.sing-box}/bin/sing-box";

  # Конфигурация для xdg-desktop-portal-termfilechooser
  xdg.configFile."xdg-desktop-portal-termfilechooser/config".text = ''
    [filechooser]
    cmd = ${pkgs.writeShellScript "yazi-portal-wrapper.sh" ''
      export TERMCMD="portal-terminal"
      exec ${pkgs.xdg-desktop-portal-termfilechooser}/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh "$@"
    ''}
  '';

  # Настройка LibreWolf для принудительного использования XDG Desktop Portal
  programs.librewolf = {
    enable = true;
    settings = {
      "widget.use-xdg-desktop-portal.file-picker" = 1;
    };
  };
}
