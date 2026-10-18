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
      { command = [ "v2rayN" ]; }
      {
        command = [
          "sh"
          "-c"
          "sleep 2 && Telegram"
        ];
      }
      { command = [ "librewolf" ]; }
      {
        command = [
          "sh"
          "-c"
          "sleep 2 && kitty --app-id startup-kitty"
        ];
      }
      # { command = [ "sh" "-c" "sleep 2 && kitty --app-id nvim -e nvim" ]; }
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
