{
  inputs,
  config,
  lib,
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
