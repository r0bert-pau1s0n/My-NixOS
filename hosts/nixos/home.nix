{ ... }:

{
  # Host-specific Noctalia settings (monitor wallpaper and lockscreen layout).
  # Loaded as a config-directory layer; GUI settings in settings.toml still win.
  xdg.configFile."noctalia/host.toml".source = ./host.toml;

  # Host-специфичные настройки рабочей среды для машины `nixos`
  # (монитор и автозапуск приложений рабочего стола).
  programs.niri.settings = {
    spawn-at-startup = [
      {
        command = [
          "dbus-update-activation-environment"
          "--all"
          "--systemd"
          "WAYLAND_DISPLAY"
          "XDG_CURRENT_DESKTOP"
        ];
      }
      { command = [ "xwayland-satellite" ]; }
      { command = [ "noctalia" ]; }
      # v2rayN и Telegram открываются на `main` — первом (стартовом)
      # воркспейсе niri: других правил автозапуска нет, поэтому окна
      # остаются на активном при старте воркспейсе.
      { command = [ "v2rayN" ]; }
      { command = [ "Telegram" ]; }
    ];

    outputs."DP-3" = {
      mode = {
        width = 1920;
        height = 1080;
        refresh = 165.003;
      };
    };
  };
}
