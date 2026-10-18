{ ... }:

{
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
      # Приложения рабочего стола намеренно НЕ запускаются автоматически:
      # v2rayN, Telegram, librewolf, kitty запускаются вручную
      # (Mod+X / Mod+T / Mod+B / Mod+Return).
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
