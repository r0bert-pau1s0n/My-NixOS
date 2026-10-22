{ config, pkgs, ... }:

let
  closeApp = pkgs.writeShellApplication {
    name = "niri-close-app";
    runtimeInputs = [
      config.programs.niri.package
      config.programs.noctalia.package
      pkgs.coreutils
      pkgs.jq
      pkgs.procps
      pkgs.xdotool
    ];
    text = ''
      notify() {
        noctalia msg notification-show "Niri" "$1" >/dev/null 2>&1 \
          || printf 'niri-close-app: %s\n' "$1" >&2
      }

      window="$(niri msg --json focused-window 2>/dev/null || true)"
      id="$(jq -r 'if type == "object" then (.id // empty) else empty end' \
        <<<"$window" 2>/dev/null || true)"
      if [ -z "$id" ]; then
        exit 0
      fi

      pid="$(jq -r 'if type == "object" then (.pid // empty) else empty end' \
        <<<"$window" 2>/dev/null || true)"
      app_id="$(jq -r 'if type == "object" then (.app_id // "unknown") else "unknown" end' \
        <<<"$window" 2>/dev/null || true)"
      [ -n "$app_id" ] || app_id="unknown"
      title="$(jq -r 'if type == "object" then (.title // empty) else empty end' \
        <<<"$window" 2>/dev/null || true)"

      close_window() {
        niri msg action close-window --id "$id" >/dev/null 2>&1
      }

      if ! [[ "$pid" =~ ^[0-9]+$ ]] || [ "$pid" -le 1 ]; then
        close_window || notify "Не удалось закрыть окно $app_id"
        exit 0
      fi

      owner="$(ps -o uid= -p "$pid" 2>/dev/null | tr -d '[:space:]')"
      if [ "$owner" != "$(id -u)" ]; then
        close_window || notify "Не удалось закрыть окно $app_id"
        exit 0
      fi

      comm="$(ps -o comm= -p "$pid" 2>/dev/null || true)"
      is_x11=false
      case "$comm" in
        *xwayland*)
          # X11 apps report xwayland-satellite as their Niri PID. Resolve the
          # real client through the X11 window title, but only when exactly one
          # client PID matches. Otherwise fall back to just closing the window.
          x11_display=""
          for arg in $(ps -o args= -p "$pid" 2>/dev/null); do
            case "$arg" in
              :[0-9]*) x11_display="$arg"; break ;;
            esac
          done
          [ -n "$x11_display" ] || x11_display=":0"

          if [ -n "$title" ]; then
            x11_pids="$(DISPLAY="$x11_display" xdotool search --name "$title" getwindowpid 2>/dev/null | sort -u || true)"
            x11_pid_count="$(printf '%s' "$x11_pids" | wc -w)"

            if [ "$x11_pid_count" -eq 1 ]; then
              client_owner="$(ps -o uid= -p "$x11_pids" 2>/dev/null | tr -d '[:space:]')"
              client_comm="$(ps -o comm= -p "$x11_pids" 2>/dev/null || true)"
              if [ "$client_owner" = "$(id -u)" ] && [[ "$client_comm" != *xwayland* ]]; then
                pid="$x11_pids"
                is_x11=true
              fi
            fi
          fi

          if ! $is_x11; then
            close_window || notify "Не удалось закрыть окно $app_id"
            exit 0
          fi
          ;;
        niri|systemd)
          close_window || notify "Не удалось закрыть окно $app_id"
          exit 0
          ;;
      esac

      if ! $is_x11; then
        windows="$(niri msg --json windows 2>/dev/null || true)"
        count="$(jq --argjson pid "$pid" \
          '[.[] | select(.pid == $pid)] | length' \
          <<<"$windows" 2>/dev/null || printf '0')"
        app_count="$(jq --argjson pid "$pid" \
          '[.[] | select(.pid == $pid) | .app_id] | unique | length' \
          <<<"$windows" 2>/dev/null || printf '0')"

        # A PID shared by different app_ids means a shared X11 host process.
        if [ "$app_count" -ne 1 ]; then
          close_window || notify "Не удалось закрыть окно $app_id"
          exit 0
        fi
      fi

      if ! close_window; then
        notify "Не удалось закрыть окно $app_id (PID $pid)"
        exit 1
      fi

      # With multiple native windows, Mod+Q must close only the focused one.
      if ! $is_x11 && [ "$count" -gt 1 ]; then
        exit 0
      fi

      # The last window may just hide in the tray. Give the app time to handle
      # the close request, then terminate the exact process.
      sleep 0.5
      if ! kill -0 "$pid" 2>/dev/null; then
        exit 0
      fi

      kill -TERM "$pid" 2>/dev/null || true

      for _ in $(seq 1 8); do
        if ! kill -0 "$pid" 2>/dev/null; then
          exit 0
        fi
        sleep 0.25
      done

      # Force close means the process must not survive a graceful request.
      kill -KILL "$pid" 2>/dev/null || true

      for _ in $(seq 1 8); do
        if ! kill -0 "$pid" 2>/dev/null; then
          exit 0
        fi
        sleep 0.25
      done

      notify "«$app_id» (PID $pid) не завершился после SIGKILL"
    '';
  };
in
{
  home.packages = [ closeApp ];
}
