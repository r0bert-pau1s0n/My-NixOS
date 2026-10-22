{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:

let
  # Классические GTK3-приложения (yad, а значит и GUI PortProton) читают
  # устаревшие имена цветов theme_*, а штатный шаблон gtk3 задаёт только
  # «новые» (window_bg_color и т.п.), поэтому такие приложения получают
  # дефолтные цвета Adwaita. Задаём алиасы (noctalia-gtk3-classic.css) и
  # подключаем их в gtk.css, который создаёт gtk-refresh.py Noctalia (при
  # наличии импорта noctalia.css он файл не перезаписывает, поэтому наш
  # import живёт). Пути абсолютные: рендерер Noctalia раскрывает только `~`.
  gtk3ClassicTemplate = {
    input_path = ./noctalia-gtk3-classic.css;
    output_path = "${config.xdg.configHome}/gtk-3.0/noctalia-gtk3-classic.css";
    hook_async = false;
    post_hook = ''
      css="${config.xdg.configHome}/gtk-3.0/gtk.css"
      line='@import url("noctalia-gtk3-classic.css");'
      ${pkgs.gnugrep}/bin/grep -qF "$line" "$css" 2>/dev/null || printf '%s\n' "$line" >> "$css"
    '';
  };

  # qBittorrent читает кастомную UI-тему только при старте. Noctalia
  # перегенерирует config.json при каждой смене палитры, а обёртка
  # (home/programs/qbittorrent/qbittorrent.nix) включает её в qBittorrent.conf.
  qbittorrentTemplate = {
    input_path = ../qbittorrent/qbittorrent-noctalia.json;
    output_path = "${config.xdg.configHome}/qBittorrent/themes/noctalia/config.json";
    hook_async = false;
  };

  kittyTemplate = {
    input_path = "${config.programs.noctalia.package}/share/noctalia/assets/templates/kitty/kitty.conf";
    output_path = "${config.xdg.configHome}/kitty/themes/noctalia.conf";
    hook_async = false;
  };

  # Встроенный шаблон Noctalia "qt" создаёт
  # ~/.config/qt6ct/colors/noctalia.conf. qt6ct.conf статический: он лишь
  # указывает на этот файл, включает custom_palette и Fusion. Цвета сюда не
  # копируются, поэтому после смены палитры Noctalia обновляет только
  # colors/noctalia.conf. Обёртка Throne (modules/throne.nix) подключает
  # qt6ct как platform theme.
  qt6ctConf = (pkgs.formats.ini { }).generate "qt6ct.conf" {
    Appearance = {
      color_scheme_path = "${config.xdg.configHome}/qt6ct/colors/noctalia.conf";
      custom_palette = true;
      style = "Fusion";
    };
  };
in
{
  # Официальный Home Manager-модуль Noctalia v5.
  # Он ставит пакет, генерирует ~/.config/noctalia/config.toml и проверяет его.
  #
  # Конфигурация разделена:
  #   1. config.toml (этот файл) — структурные значения: templates/hooks с
  #      store-путями, каталог обоев и privacy-флаги.
  #   2. home/programs/noctalia/settings.toml — GUI-настройки. Activation создаёт
  #      прямой симлинк из ~/.local/state/noctalia/settings.toml на этот файл,
  #      Noctalia пишет сквозь него, а изменения сразу видны в git diff.
  #   3. ~/.config/noctalia/host.toml — host-specific мониторы/lockscreen.
  imports = [ inputs.noctalia.homeModules.default ];

  programs.noctalia = {
    enable = true;

    # Оформление, панель, виджеты и прочие GUI-настройки живут в
    # home/programs/noctalia/settings.toml и пишутся туда самим Noctalia. Здесь
    # остаются только структурные значения, которые нельзя хранить в
    # GUI-файле: store-пути шаблонов и хуков, каталог обоев, privacy-флаги.
    settings = {
      # pywalfox: Noctalia генерирует ~/.cache/wal/colors.json и ставит
      # native messaging host для расширения Pywalfox (см. миграцию ниже).
      theme.templates = {
        enable_community_templates = true;
        builtin_ids = [
          "btop"
          "gtk3"
          "niri"
          "qt"
        ];
        community_ids = [
          "opencode"
          "pywalfox"
          "discord"
          "telegram"
          "neovim"
          "vscode"
          "steam"
          "tmux"
          "yazi"
        ];

        # Классические GTK3-приложения — см. gtk3ClassicTemplate выше.
        user."gtk3-classic" = gtk3ClassicTemplate;
        user."qbittorrent" = qbittorrentTemplate;
        user."kitty" = kittyTemplate;
      };

      # ── Хуки ──────────────────────────────────────────────────────────
      # После смены палитры Noctalia перегенерирует цвета у уже запущенных
      # приложений без их перезапуска. Хуки выполняются после того, как все
      # шаблоны записаны на диск.
      #
      # kitty: перегенерируется themes/noctalia.conf (include в kitty.conf).
      # Builtin-шаблон kitty отключён, потому что его apply.sh пишет в read-only
      # store-симлинк kitty.conf. User-шаблон не имеет post_hook, поэтому шлём
      # kitty сигнал перезагрузки конфига сами: открытые окна перекрашиваются
      # без перезапуска (kitty.apply_new_options). NixOS-обёртка kitty
      # называется `.kitty-wrapped`, поэтому пробуем оба имени процесса;
      # `|| true` — если kitty не запущен.
      #
      # yazi: шаблон сначала перезаписывает flavors/noctalia.yazi/flavor.toml,
      # после чего рассылаем action `app:theme` через DDS (receiver 0 =
      # broadcast всем инстансам) — каждый запущенный yazi перечитывает flavor
      # с диска вживую, сохраняя точные цвета Noctalia. `|| true` — если yazi
      # не запущен (нет DDS-сервера).
      #
      # opencode: шаблон перезаписывает themes/matugen.json, но OpenCode 1.19
      # не следит за файлами — он перечитывает кастомные темы только по SIGUSR2
      # (ThemeProvider -> subscribeRefresh). Команда процесса обрезана ядром до
      # 15 символов, поэтому имя `.opencode-wrapped` видно как `.opencode-wrapp`.
      # `|| true` — если opencode не запущен; SIGUSR2 — дизайнерский сигнал
      # OpenCode для перечитывания тем, сессия при этом сохраняется.
      hooks.colors_changed = [
        "${pkgs.procps}/bin/pkill -USR1 -x '.kitty-wrapped' || ${pkgs.procps}/bin/pkill -USR1 -x kitty || true"
        "${pkgs.yazi}/bin/ya emit-to 0 app:theme || true"
        "${pkgs.procps}/bin/pkill -USR2 -x '.opencode-wrapp' || true"
      ];

      wallpaper = {
        enabled = true;
        directory = "${config.xdg.configHome}/wallpapers";
      };

      shell = {
        telemetry_enabled = false;
        setup_wizard_enabled = false;
      };
    };
  };

  # qt6ct читает этот файл при старте. Палитра живёт отдельно, в
  # colors/noctalia.conf, и перегенерируется Noctalia без перезапуска qt6ct.
  xdg.configFile."qt6ct/qt6ct.conf".source = qt6ctConf;

  # GUI-настройки Noctalia пишутся в ~/.local/state/noctalia/settings.toml.
  # Держим этот файл прямым симлинком на файл в Git-репозитории: Noctalia
  # пишет атомарно сквозь симлинк, поэтому изменения из GUI сразу видны в
  # git diff. Ссылку создаём сами после linkGeneration, чтобы не зависеть от
  # xdg.stateFile/force и не проходить через промежуточный store-симлинк.
  home.activation.noctaliaSettingsLink = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
    target="${config.xdg.stateHome}/noctalia/settings.toml"
    repo="${config.home.homeDirectory}/nix/home/programs/noctalia/settings.toml"

    [ -f "$repo" ] || { echo "Noctalia settings file is missing: $repo"; exit 1; }

    $DRY_RUN_CMD mkdir -p -- "$(dirname -- "$target")" || exit 1

    if [ -L "$target" ] && [ "$(readlink "$target")" = "$repo" ]; then
      :
    elif [ -L "$target" ] && [ "$(readlink -f -- "$target")" = "$(readlink -f -- "$repo")" ]; then
      $DRY_RUN_CMD ln -sfn -- "$repo" "$target" || exit 1
    elif [ -d "$target" ] && [ ! -L "$target" ]; then
      echo "Refusing to replace directory with Noctalia settings symlink: $target"
      exit 1
    else
      if [ -e "$target" ] || [ -L "$target" ]; then
        backup="$target.bak-$(date +%Y%m%d-%H%M%S)"
        [ -e "$backup" ] || [ -L "$backup" ] && backup="$backup-$$"
        $DRY_RUN_CMD mv -- "$target" "$backup" || exit 1
      fi
      $DRY_RUN_CMD ln -s -- "$repo" "$target" || exit 1
    fi

    if [ -z "''${DRY_RUN:-}" ]; then
      NOCTALIA_CONFIG_HOME="${config.xdg.configHome}" \
      NOCTALIA_STATE_HOME="${config.xdg.stateHome}" \
        ${lib.getExe config.programs.noctalia.package} config validate
    fi
  '';

  home.activation.noctaliaWritableTemplateTargets = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
    make_writable() {
      target="$1"

      if [ -L "$target" ]; then
        source="$(readlink -f -- "$target")" || return 1
        $DRY_RUN_CMD rm -f -- "$target" || return 1
        $DRY_RUN_CMD install -m 0644 -- "$source" "$target" || return 1
      elif [ -e "$target" ]; then
        $DRY_RUN_CMD chmod u+w -- "$target" || return 1
      fi
    }

    for relative in "tmux/tmux.conf" "yazi/theme.toml"; do
      make_writable "${config.xdg.configHome}/$relative"
    done
  '';

  # Старое имя host-слоя: убираем 90-host.toml в backup, чтобы в config-каталоге
  # не оставался устаревший файл, который загружается раньше config.toml.
  home.activation.noctaliaHostLayerMigration =
    lib.hm.dag.entryBetween [ "linkGeneration" ] [ "writeBoundary" ]
      ''
        legacy="${config.xdg.configHome}/noctalia/90-host.toml"

        if [ -e "$legacy" ] || [ -L "$legacy" ]; then
          backup="$legacy.bak-$(date +%Y%m%d-%H%M%S)"
          [ -e "$backup" ] || [ -L "$backup" ] && backup="$backup-$$"
          $DRY_RUN_CMD mv -- "$legacy" "$backup" || exit 1
        fi
      '';

  # Pywalfox: от v4 остался «чужой» native messaging manifest, указывающий на
  # несуществующий store-путь pywalfox-native 2.9.0. Noctalia (firefox-theme)
  # не перезаписывает чужие host'ы, поэтому её собственный manifest не ставился
  # и расширение не могло подключиться к daemon. Удаляем легаси-файл (с бэкапом),
  # только если он ещё не указывает на noctalia. Идемпотентно.
  home.activation.noctaliaPywalfoxMigration = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mf="$HOME/.mozilla/native-messaging-hosts/pywalfox.json"
    if [ -f "$mf" ] && ! grep -q 'noctalia' "$mf"; then
      $DRY_RUN_CMD cp -a "$mf" "$mf.pywalfox-native.bak"
      $DRY_RUN_CMD rm -f "$mf"
    fi
  '';

  # niri-flake создаёт config.kdl как симлинк, а от v4 остался обычный файл
  # (его дописывал activation-хук appendNoctaliaInclude). Удаляем его перед
  # проверками HM, чтобы Home Manager смог создать ссылку.
  home.activation.cleanupNiriConfig = lib.hm.dag.entryBefore [ "checkLinkTargets" ] ''
    FILE="${config.xdg.configHome}/niri/config.kdl"
    if [ -e "$FILE" ] && [ ! -L "$FILE" ]; then
      $DRY_RUN_CMD rm -f -- "$FILE" || exit 1
    fi
  '';
}
