{ config, pkgs, ... }:

let
  # Telegram на холодном старте появляется с задержкой. Запускаем Throne и
  # Telegram сразу, а qBittorrent — только после появления обоих окон.
  # Telegram открывается maximized (Mod+F) ещё при маппинге окна; после
  # старта qBittorrent скрипт выравнивает колонки и снова фокусирует Telegram.
  startupLayout = pkgs.writeShellApplication {
    name = "niri-startup-layout";
    runtimeInputs = [
      config.programs.niri.package
      pkgs.coreutils
      pkgs.jq
    ];
    text = ''
      uid="$(id -u)"
      socket=""

      find_socket() {
        local candidate
        for candidate in "''${NIRI_SOCKET:-}" /run/user/"$uid"/niri.wayland-*.sock; do
          [ -n "$candidate" ] || continue
          [ -S "$candidate" ] || continue
          if timeout 0.5s env NIRI_SOCKET="$candidate" niri msg --json version >/dev/null 2>&1; then
            printf '%s\n' "$candidate"
            return 0
          fi
        done
        return 1
      }

      niri_json() {
        timeout 1s niri msg --json "$1" 2>/dev/null
      }

      focus_window() {
        timeout 1s niri msg action focus-window --id "$1" >/dev/null 2>&1 || return 1
        local current=""
        for _ in $(seq 1 10); do
          current="$(timeout 0.2s niri msg --json focused-window 2>/dev/null \
            | jq -r 'if type == "object" then (.id // empty) else empty end' \
            || true)"
          [ "$current" = "$1" ] && return 0
          sleep 0.05
        done
        return 1
      }

      move_column() {
        focus_window "$1" || return 0
        timeout 1s niri msg action move-column-to-index "$2" >/dev/null 2>&1 || true
      }

      main_id=""
      throne_id=""
      telegram_id=""
      qbittorrent_id=""
      deadline=$((SECONDS + 25))

      # 1. Ждём Throne и Telegram, но пока не запускаем qBittorrent.
      while (( SECONDS < deadline )); do
        if [ -z "$socket" ]; then
          socket="$(find_socket)" || {
            sleep 0.2
            continue
          }
          export NIRI_SOCKET="$socket"
        fi

        workspaces="$(niri_json workspaces)" || {
          sleep 0.2
          continue
        }
        main_id="$(jq -r 'first(.[] | select(.name == "main") | .id) // empty' <<<"$workspaces")"

        if [ -n "$main_id" ]; then
          windows="$(niri_json windows)" || {
            sleep 0.2
            continue
          }
          throne_id="$(jq -r --argjson ws "$main_id" 'first(.[] | select(.app_id == "Throne" and .workspace_id == $ws) | .id) // empty' <<<"$windows")"
          telegram_id="$(jq -r --argjson ws "$main_id" 'first(.[] | select(.app_id == "org.telegram.desktop" and .workspace_id == $ws and (((.title // "") | startswith("Media viewer")) | not)) | .id) // empty' <<<"$windows")"
        fi

        if [ -n "$throne_id" ] && [ -n "$telegram_id" ]; then
          break
        fi
        sleep 0.2
      done

      # 2. Ставим Throne слева, Telegram справа и показываем Telegram.
      if [ -n "$throne_id" ] && [ -n "$telegram_id" ]; then
        move_column "$throne_id" 1
        move_column "$telegram_id" 2
        focus_window "$telegram_id" || true
      elif [ -n "$throne_id" ]; then
        focus_window "$throne_id" || true
      fi

      # 3. qBittorrent — последним, уже после Telegram.
      timeout 1s niri msg action spawn -- qbittorrent >/dev/null 2>&1 || true

      # 4. Ждём окно qBittorrent и ставим его справа от Telegram.
      if [ -n "$main_id" ]; then
        qbittorrent_deadline=$((SECONDS + 30))
        while (( SECONDS < qbittorrent_deadline )); do
          windows="$(niri_json windows)" || {
            sleep 0.2
            continue
          }
          qbittorrent_id="$(jq -r --argjson ws "$main_id" 'first(.[] | select(.app_id == "org.qbittorrent.qBittorrent" and .workspace_id == $ws and ((.title // "") | startswith("qBittorrent"))) | .id) // empty' <<<"$windows")"
          [ -n "$qbittorrent_id" ] && break
          sleep 0.2
        done
      fi

      if [ -n "$throne_id" ] && [ -n "$telegram_id" ] && [ -n "$qbittorrent_id" ]; then
        move_column "$throne_id" 1
        move_column "$qbittorrent_id" 3
        move_column "$telegram_id" 2
      fi

      # 5. Telegram остаётся на экране после старта qBittorrent.
      if [ -n "$telegram_id" ]; then
        focus_window "$telegram_id" || true
      fi
    '';
  };
in
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
      # Throne и Telegram открываются на `main` первыми. qBittorrent
      # запускает niri-startup-layout уже после появления их окон.
      { command = [ "Throne" ]; }
      { command = [ "Telegram" ]; }
      { command = [ "${startupLayout}/bin/niri-startup-layout" ]; }
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
