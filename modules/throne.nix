{ lib, pkgs, ... }:
let
  # Throne хранит настройки в SQLite. «System» заставляет его взять палитру
  # из Qt platform theme (qt6ct). remember_enable + tun_mode_enabled включают
  # автозапуск последнего профиля в TUN-режиме, когда ядро готово.
  # Не трогаем базу, пока GUI запущен: при выходе он может записать свои
  # значения обратно и затереть наши настройки.
  startupPrefs = pkgs.writeShellApplication {
    name = "throne-startup-prefs";
    runtimeInputs = with pkgs; [
      coreutils
      sqlite
    ];
    text = ''
      db="''${XDG_CONFIG_HOME:-$HOME/.config}/Throne/config/throne.db"
      uid="$(id -u)"

      # Throne создаёт базу при первом запуске, поэтому до этого момента
      # записывать prefs некуда. Схему БД вручную не создаём.
      [ -f "$db" ] || exit 0

      # Ищем именно GUI по /proc/*/exe, а не обёртку: Throne запускается
      # через shell/C-обёртку, и pgrep по имени поймал бы её саму. Учитываем
      # только процессы текущего пользователя: чужой Throne не должен
      # блокировать наши prefs.
      for exe in /proc/[0-9]*/exe; do
        target="$(readlink -f -- "$exe" 2>/dev/null)" || continue
        case "$target" in
          */share/throne/Throne)
            pid="''${exe#/proc/}"
            pid="''${pid%/exe}"
            owner="$(stat -c '%u' -- "/proc/$pid" 2>/dev/null)" || continue
            [ "$owner" = "$uid" ] && exit 0
            ;;
        esac
      done

      sql="INSERT INTO settings(key, value) VALUES
        ('theme', 'System'),
        ('remember_enable', 'true'),
        ('tun_mode_enabled', 'true')
      ON CONFLICT(key) DO UPDATE SET value = excluded.value
      WHERE settings.value <> excluded.value;"

      if ! timeout 2s sqlite3 -cmd '.timeout 1000' "$db" "$sql"; then
        echo "throne-startup: could not apply startup prefs; continuing" >&2
      fi
    '';
  };

  waitForPalette = pkgs.writeShellApplication {
    name = "throne-wait-for-palette";
    runtimeInputs = [ pkgs.coreutils ];
    text = ''
      palette="''${XDG_CONFIG_HOME:-$HOME/.config}/qt6ct/colors/noctalia.conf"

      for _ in $(seq 1 30); do
        [ -s "$palette" ] && exit 0
        sleep 0.5
      done

      echo "throne-startup: qt6ct palette not ready after 15s; continuing" >&2
    '';
  };

  # qt6ct — это Qt platform theme plugin, а не отдельный стиль. Оборачиваем
  # bin/Throne, чтобы переменные получили и GUI, и его дочерние процессы.
  # Исходная C-обёртка Throne добавляет свои пути через --prefix, поэтому
  # QT_PLUGIN_PATH с qt6ct не затирается.
  throneNoctalia = pkgs.symlinkJoin {
    name = "throne-noctalia";
    paths = [ pkgs.throne ];
    nativeBuildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/Throne \
        --set QT_QPA_PLATFORMTHEME qt6ct \
        --prefix QT_PLUGIN_PATH : ${pkgs.qt6Packages.qt6ct}/lib/qt-6/plugins \
        --run '${lib.getExe waitForPalette} || true' \
        --run '${lib.getExe startupPrefs} || true'
    '';
    meta = pkgs.throne.meta;
  };
in
{
  # Throne ставится системным модулем, чтобы TUN-режим получил
  # security-wrapper ThroneCore и polkit-правило для systemd-resolved.
  programs.throne = {
    enable = true;
    package = throneNoctalia;
    tunMode.enable = true;
  };
}
