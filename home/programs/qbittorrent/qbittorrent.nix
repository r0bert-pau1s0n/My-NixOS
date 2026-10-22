{
  config,
  lib,
  pkgs,
  ...
}:

let
  # qBittorrent applies its custom UI theme only at startup, so enable it
  # before every launch. Do not rewrite the config while another instance is
  # running: that instance may overwrite the file when it exits.
  prefsSync = pkgs.writeShellApplication {
    name = "qbittorrent-noctalia-prefs";
    runtimeInputs = with pkgs; [
      coreutils
      diffutils
      gawk
      gnugrep
      procps
    ];
    text = ''
      conf="${config.xdg.configHome}/qBittorrent/qBittorrent.conf"
      theme="${config.xdg.configHome}/qBittorrent/themes/noctalia/config.json"

      if [ ! -f "$theme" ]; then
        exit 0
      fi

      # Exclude this wrapper's parent PID, but detect a real running instance
      # of the current user only. The wrapper changes argv[0] to qbittorrent,
      # so match the full command line rather than the executable name.
      if pgrep -u "$(id -u)" -f '(^|/)qbittorrent( |$)' | grep -vqx "$PPID"; then
        exit 0
      fi

      mkdir -p -- "$(dirname -- "$conf")"

      if [ ! -e "$conf" ]; then
        printf '[Preferences]\n' > "$conf"
      fi

      tmp="$(mktemp --tmpdir="$(dirname -- "$conf")" qBittorrent.conf.XXXXXX)"
      trap 'rm -f -- "$tmp"' EXIT

      awk -v theme_path="$theme" -f ${./qbittorrent-noctalia-prefs.awk} "$conf" > "$tmp"

      if ! cmp -s -- "$conf" "$tmp"; then
        backup="$conf.bak-noctalia"
        [ -e "$backup" ] || cp -a -- "$conf" "$backup"
        chmod --reference="$conf" "$tmp"
        mv -- "$tmp" "$conf"
        trap - EXIT
      fi
    '';
  };

  # Niri positions a transient dialog relative to the parent window's place in
  # the scrolling layout. Focus the main window before qBittorrent maps the
  # dialog so Niri scrolls it into view instead of clamping the dialog to the
  # edge of the current viewport.
  focusMain = pkgs.writeShellApplication {
    name = "qbittorrent-niri-focus-main";
    runtimeInputs = [
      config.programs.niri.package
      pkgs.coreutils
      pkgs.jq
    ];
    text = ''
      uid="$(id -u)"
      main_id=""
      socket=""

      # NIRI_SOCKET can be stale when qBittorrent is started by a long-lived
      # service, so prefer it but fall back to all sockets of the current user.
      for candidate in "''${NIRI_SOCKET:-}" /run/user/"$uid"/niri.wayland-*.sock; do
        [ -n "$candidate" ] || continue
        [ -S "$candidate" ] || continue

        windows="$(NIRI_SOCKET="$candidate" timeout 0.5s niri msg --json windows 2>/dev/null)" || continue
        candidate_id="$(jq -r 'first(.[] | select(.app_id == "org.qbittorrent.qBittorrent" and (.title | startswith("qBittorrent"))) | .id) // empty' <<<"$windows")"

        if [ -n "$candidate_id" ]; then
          main_id="$candidate_id"
          socket="$candidate"
          break
        fi
      done

      [ -n "$main_id" ] || exit 0

      export NIRI_SOCKET="$socket"

      get_focused_id() {
        timeout 0.2s niri msg --json focused-window 2>/dev/null \
          | jq -r 'if type == "object" then (.id // empty) else empty end' \
          || true
      }

      timeout 0.5s niri msg action focus-window --id "$main_id" >/dev/null 2>&1 || exit 0

      # Focusing an already visible window may not move the viewport. Center it
      # explicitly so Niri computes a stable position for the transient dialog.
      timeout 0.5s niri msg action center-window --id "$main_id" >/dev/null 2>&1 || true

      # Niri applies focus asynchronously. Wait for the IPC state to catch up,
      # then allow the viewport scroll to settle before the dialog is mapped.
      for _ in $(seq 1 5); do
        current_id="$(get_focused_id)"
        if [ "$current_id" = "$main_id" ]; then
          break
        fi
        sleep 0.05
      done

      [ "$current_id" = "$main_id" ] || exit 0
      sleep 0.25
    '';
  };

  qbittorrentPatched = pkgs.qbittorrent.overrideAttrs (old: {
    patches = (old.patches or [ ]) ++ [
      # qBittorrent only defines custom colours for Active and Disabled; repeat
      # them for Inactive so unfocused windows keep readable contrast.
      ./qbittorrent-inactive-palette.patch

      # Attach the add-torrent dialog to the main window and give Niri a stable
      # transient parent instead of hiding/re-showing the main window.
      ./qbittorrent-add-dialog-transient-parent.patch
    ];
  });

  qbittorrent = pkgs.symlinkJoin {
    name = "qbittorrent-noctalia";
    paths = [ qbittorrentPatched ];
    nativeBuildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/qbittorrent \
        --set-default QBITTORRENT_NIRI_FOCUS_MAIN ${lib.getExe focusMain} \
        --run '${lib.getExe prefsSync} || true'
    '';
    inherit (qbittorrentPatched) meta;
  };
in
{
  home.packages = [ qbittorrent ];
}
