{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:

{
  # Официальный Home Manager-модуль Noctalia v5.
  # Он сам ставит пакет `noctalia`, генерирует ~/.config/noctalia/config.toml
  # и на этапе сборки прогоняет `noctalia config validate` (checkConfig).
  imports = [ inputs.noctalia.homeModules.default ];

  programs.noctalia = {
    enable = true;

    settings = {
      # ── Тема ──────────────────────────────────────────────────────────
      theme = {
        mode = "dark";
        shell_mode = "follow";
        source = "wallpaper";
        wallpaper_scheme = "m3-tonal-spot";
        sync_color_scheme = true;
      };

      # ── Оболочка ──────────────────────────────────────────────────────
      shell = {
        font_family = "JetBrainsMono Nerd Font Mono";
        lang = "en";
        telemetry_enabled = false;
        setup_wizard_enabled = false;
        animation.enabled = false;
        screen_corners.enabled = true;
      };

      # ── Панель ────────────────────────────────────────────────────────
      bar.default = {
        position = "top";
        thickness = 34;
        margin_ends = 4;
        margin_edge = 4;
        radius = 12;
        background_opacity = 1.0;
        widget_spacing = 6;
        start = [
          "workspaces"
          "active-window"
          "audio-visualizer"
        ];
        center = [ "clock" ];
        end = [
          "sysmon"
          "volume"
          "bluetooth"
          "notifications"
          "clipboard"
          "battery"
          "keyboard-layout"
          "taskbar"
          "control-center"
        ];
      };

      # ── Обои ──────────────────────────────────────────────────────────
      wallpaper = {
        enabled = true;
        directory = "${config.xdg.configHome}/wallpapers";
      };

      # ── Локация/погода ────────────────────────────────────────────────
      location = {
        auto_locate = false;
        address = "Perm";
      };

      # ── Хуки ──────────────────────────────────────────────────────────
      # После смены палитры Noctalia перегенерирует цвета у уже запущенных
      # приложений без их перезапуска. Хуки выполняются после того, как все
      # шаблоны записаны на диск.
      #
      # kitty: перегенерируется themes/noctalia.conf (include в kitty.conf), но
      # штатный templates/kitty/apply.sh падает на read-only store-симлинке
      # kitty.conf и не доходит до pkill -USR1. Поэтому шлём kitty сигнал
      # перезагрузки конфига сами: открытые окна перекрашиваются без
      # перезапуска (kitty.apply_new_options). NixOS-обёртка kitty называется
      # `.kitty-wrapped`, поэтому пробуем оба имени процесса; `|| true` — если
      # kitty не запущен.
      #
      # yazi: шаблон сначала перезаписывает flavors/noctalia.yazi/flavor.toml,
      # после чего рассылаем action `app:theme` через DDS (receiver 0 =
      # broadcast всем инстансам) — каждый запущенный yazi перечитывает flavor
      # с диска вживую, сохраняя точные цвета Noctalia. `|| true` — если yazi
      # не запущен (нет DDS-сервера).
      hooks.colors_changed = [
        "${pkgs.procps}/bin/pkill -USR1 -x '.kitty-wrapped' || ${pkgs.procps}/bin/pkill -USR1 -x kitty || true"
        "${pkgs.yazi}/bin/ya emit-to 0 app:theme || true"
      ];
    };
  };

  # niri-flake создаёт config.kdl как симлинк, а от v4 остался обычный файл
  # (его дописывал activation-хук appendNoctaliaInclude). Удаляем его перед
  # проверками HM, чтобы Home Manager смог создать ссылку.
  home.activation.cleanupNiriConfig = lib.hm.dag.entryBefore [ "checkLinkTargets" ] ''
    FILE="${config.xdg.configHome}/niri/config.kdl"
    if [ -e "$FILE" ] && [ ! -L "$FILE" ]; then
      rm -f "$FILE"
    fi
  '';
}
