# ~/nix/home/programs/niri.nix
{ config, lib, pkgs, ... }:

{
  programs.niri = {
    enable = true;
    # ДОБАВЛЕННАЯ СТРОКА: заставляем HM поставить новую версию
    package = pkgs.niri-unstable;
    settings = {
      # === НАЧАЛЬНЫЙ ЗАПУСК ===
      spawn-at-startup = [
        { command = [ "xwayland-satellite" ]; }
        { command = [ "sh" "-c" "sleep 2 && export DISPLAY=:0" ]; }
        { command = [ "noctalia-shell" ]; }
        { command = [ "v2rayN" ]; }
        { command = [ "sh" "-c" "sleep 2 && Telegram" ]; }
        { command = [ "librewolf" ]; }
        { command = [ "sh" "-c" "sleep 2 && kitty --app-id nvim -e nvim" ]; }
      ];

      # === АНИМАЦИИ (Обновлено: добавлено kind) ===
      animations = {
        window-open = { kind.spring = { damping-ratio = 1.0; stiffness = 600; epsilon = 0.001; }; };
        window-close = { kind.spring = { damping-ratio = 1.0; stiffness = 500; epsilon = 0.001; }; };
        workspace-switch = { kind.spring = { damping-ratio = 0.8; stiffness = 1000; epsilon = 0.001; }; };
        horizontal-view-movement = { kind.spring = { damping-ratio = 0.8; stiffness = 1000; epsilon = 0.0001; }; };
      };

      # === ВВОД ===
      gestures = { hot-corners = { enable = false; }; };
      
      input = {
        keyboard = {
          xkb = {
            layout = "us,ru";
            options = "grp:alt_shift_toggle,compose:ralt,ctrl:nocaps";
          };
          numlock = true;
        };
        touchpad = { tap = true; natural-scroll = true; };
      };

      # === ОКРУЖЕНИЕ И CSD ===
      prefer-no-csd = true;
      
      environment = {
        XDG_SESSION_TYPE = "wayland";
        MOZ_ENABLE_WAYLAND = "1";
        QT_QPA_PLATFORM = "wayland";
        GDK_BACKEND = "wayland";
        XDG_CURRENT_DESKTOP = "niri";
        XDG_SESSION_DESKTOP = "niri";
      };

      # === МОНИТОРЫ (OUTPUTS) ===
      outputs."DP-3" = {
        mode = {
          width = 1920;
          height = 1080;
          refresh = 165.0; # 165 Гц
        };
      };

      hotkey-overlay = { skip-at-startup = true; };

      # === LAYOUT (РАЗМЕТКА) ===
      layout = {
        gaps = 12;
        center-focused-column = "on-overflow";
        
        preset-column-widths = [
          { proportion = 0.33333; }
          { proportion = 0.5; }
          { proportion = 0.66667; }
          { fixed = 960; }
        ];
        
        default-column-width = { proportion = 0.5; };
        
        # Обновлено: active.gradient и inactive.color
        focus-ring = {
          width = 2;
          inactive.color = "#1f1f28";
          active.gradient = {
            from = "#76946a";
            to = "#cba6f7";
            angle = 135;
          };
        };
        
        border = { enable = false; };
        
        shadow = {
          enable = true;
          draw-behind-window = true;
          softness = 20;
          spread = 2;
          color = "#1f1f2870";
          offset = { x = 0; y = 3; };
        };
      };

      # === РАБОЧИЕ СТОЛЫ ===
      workspaces = {
        "main" = {};
        "two" = {};
      };

      # === ГОРЯЧИЕ КЛАВИШИ (BINDS) ===
      binds = {
        # Система
        "Mod+Shift+Slash" = { action.show-hotkey-overlay = {}; };
        "Super+Alt+L" = { action.spawn = "swaylock"; hotkey-overlay.title = "Lock the Screen: swaylock"; };
        "Mod+Shift+P" = { action.power-off-monitors = {}; };
        "Mod+M" = { action.quit = {}; };
        "Ctrl+Alt+Delete" = { action.quit = {}; };
        "Mod+Escape" = { action.toggle-keyboard-shortcuts-inhibit = {}; allow-inhibiting = false; };

        # Запуск приложений
        "Mod+Return" = { action.spawn = "kitty"; hotkey-overlay.title = "Terminal: kitty"; };
        "Mod+T" = { action.spawn = "Telegram"; hotkey-overlay.title = "Telegram"; };
        "Mod+B" = { action.spawn = "librewolf"; hotkey-overlay.title = "LibreWolf"; };
        "Mod+N" = { action.spawn = [ "kitty" "--app-id" "nvim" "-e" "nvim" ]; hotkey-overlay.title = "Neovim"; };
        "Mod+X" = { action.spawn = "v2rayN"; hotkey-overlay.title = "V2RayN"; };
        "Mod+D" = { action.spawn = "code"; hotkey-overlay.title = "VS Code"; };
        "Mod+E" = { action.spawn = [ "kitty" "--app-id" "yazi" "-e" "yazi" ]; hotkey-overlay.title = "File Manager: Yazi"; };

        # Утилиты Noctalia
        "Mod+Y" = { action.spawn = [ "noctalia-shell" "ipc" "call" "controlCenter" "toggle" ]; hotkey-overlay.title = "Control Center: noctalia controlCenter"; };
        "Mod+R" = { action.spawn = [ "noctalia-shell" "ipc" "call" "launcher" "toggle" ]; hotkey-overlay.title = "Application Launcher: Noctalia"; };
        "Mod+V" = { action.spawn = [ "noctalia-shell" "ipc" "call" "plugin:clipboard" "toggle" ]; hotkey-overlay.title = "Clipboard History: Noctalia"; };
        "Mod+Shift+V" = { action.spawn = [ "noctalia-shell" "ipc" "call" "plugin:clipboard" "wipe" ]; hotkey-overlay.title = "Clipboard Wipe: Noctalia"; };
        "Mod+Shift+Q" = { action.spawn = [ "noctalia-shell" "ipc" "call" "sessionMenu" "toggle" ]; hotkey-overlay.title = "Session Menu: noctalia sessionMenu"; };

        # Фокус
        "Mod+H" = { action.focus-column-left = {}; };
        "Mod+L" = { action.focus-column-right = {}; };
        "Mod+Home" = { action.focus-column-first = {}; };
        "Mod+End" = { action.focus-column-last = {}; };
        "Mod+Ctrl+H" = { action.focus-monitor-left = {}; };
        "Mod+Ctrl+J" = { action.focus-monitor-down = {}; };
        "Mod+Ctrl+K" = { action.focus-monitor-up = {}; };
        "Mod+Ctrl+L" = { action.focus-monitor-right = {}; };

        # Перемещение
        "Mod+Shift+H" = { action.move-column-left = {}; };
        "Mod+Shift+J" = { action.move-window-down = {}; };
        "Mod+Shift+K" = { action.move-window-up = {}; };
        "Mod+Shift+L" = { action.move-column-right = {}; };
        "Mod+Ctrl+Home" = { action.move-column-to-first = {}; };
        "Mod+Ctrl+End" = { action.move-column-to-last = {}; };
        "Mod+Ctrl+Shift+H" = { action.move-column-to-monitor-left = {}; };
        "Mod+Ctrl+Shift+J" = { action.move-column-to-monitor-down = {}; };
        "Mod+Ctrl+Shift+K" = { action.move-column-to-monitor-up = {}; };
        "Mod+Ctrl+Shift+L" = { action.move-column-to-monitor-right = {}; };

        # Воркспейсы
        "Mod+J" = { action.focus-workspace-down = {}; };
        "Mod+K" = { action.focus-workspace-up = {}; };
        "Mod+Ctrl+U" = { action.move-column-to-workspace-down = {}; };
        "Mod+Ctrl+I" = { action.move-column-to-workspace-up = {}; };
        "Mod+Alt+U" = { action.move-workspace-down = {}; };
        "Mod+Alt+I" = { action.move-workspace-up = {}; };
        "Mod+1" = { action.focus-workspace = 1; };
        "Mod+2" = { action.focus-workspace = 2; };
        "Mod+3" = { action.focus-workspace = 3; };
        "Mod+4" = { action.focus-workspace = 4; };
        "Mod+5" = { action.focus-workspace = 5; };
        "Mod+6" = { action.focus-workspace = 6; };
        "Mod+7" = { action.focus-workspace = 7; };
        "Mod+8" = { action.focus-workspace = 8; };
        "Mod+9" = { action.focus-workspace = 9; };
        "Mod+0" = { action.focus-workspace = 10; };
        "Mod+Shift+1" = { action.move-column-to-workspace = 1; };
        "Mod+Shift+2" = { action.move-column-to-workspace = 2; };
        "Mod+Shift+3" = { action.move-column-to-workspace = 3; };
        "Mod+Shift+4" = { action.move-column-to-workspace = 4; };
        "Mod+Shift+5" = { action.move-column-to-workspace = 5; };
        "Mod+Shift+6" = { action.move-column-to-workspace = 6; };
        "Mod+Shift+7" = { action.move-column-to-workspace = 7; };
        "Mod+Shift+8" = { action.move-column-to-workspace = 8; };
        "Mod+Shift+9" = { action.move-column-to-workspace = 9; };
        "Mod+Shift+0" = { action.move-column-to-workspace = 10; };
        "Mod+Tab" = { action.focus-workspace-previous = {}; };

        # Колесо мыши
        "Mod+WheelScrollDown" = { action.focus-workspace-down = {}; cooldown-ms = 150; };
        "Mod+WheelScrollUp" = { action.focus-workspace-up = {}; cooldown-ms = 150; };
        "Mod+Ctrl+WheelScrollDown" = { action.move-column-to-workspace-down = {}; cooldown-ms = 150; };
        "Mod+Ctrl+WheelScrollUp" = { action.move-column-to-workspace-up = {}; cooldown-ms = 150; };
        "Mod+WheelScrollRight" = { action.focus-column-right = {}; };
        "Mod+WheelScrollLeft" = { action.focus-column-left = {}; };
        "Mod+Ctrl+WheelScrollRight" = { action.move-column-right = {}; };
        "Mod+Ctrl+WheelScrollLeft" = { action.move-column-left = {}; };
        "Mod+Shift+WheelScrollDown" = { action.focus-column-right = {}; };
        "Mod+Shift+WheelScrollUp" = { action.focus-column-left = {}; };
        "Mod+Ctrl+Shift+WheelScrollDown" = { action.move-column-right = {}; };
        "Mod+Ctrl+Shift+WheelScrollUp" = { action.move-column-left = {}; };

        # Размеры
        "Mod+Minus" = { action.set-column-width = "-10%"; };
        "Mod+Equal" = { action.set-column-width = "+10%"; };
        "Mod+Shift+Minus" = { action.set-window-height = "-10%"; };
        "Mod+Shift+Equal" = { action.set-window-height = "+10%"; };
        "Mod+Alt+R" = { action.switch-preset-column-width = {}; };
        "Mod+Alt+Shift+R" = { action.switch-preset-column-width-back = {}; };
        "Mod+Ctrl+Alt+Shift+R" = { action.switch-preset-window-height = {}; };
        "Mod+Ctrl+Alt+R" = { action.reset-window-height = {}; };

        # Состояния окон
        "Mod+Q" = { action.close-window = {}; };
        "Mod+F" = { action.maximize-column = {}; };
        "Mod+Shift+F" = { action.fullscreen-window = {}; };
        "Mod+Alt+F" = { action.toggle-window-floating = {}; };
        "Mod+Shift+M" = { action.maximize-column = {}; };
        "Mod+Ctrl+F" = { action.expand-column-to-available-width = {}; };
        "Mod+C" = { action.center-column = {}; };
        "Mod+Ctrl+C" = { action.center-visible-columns = {}; };
        "Mod+S" = { action.toggle-overview = {}; repeat = false; };
        "Mod+Alt+W" = { action.toggle-column-tabbed-display = {}; };

        # Колонны
        "Mod+Less" = { action.consume-or-expel-window-left = {}; };
        "Mod+Greater" = { action.consume-or-expel-window-right = {}; };
        "Mod+Comma" = { action.consume-window-into-column = {}; };
        "Mod+Period" = { action.expel-window-from-column = {}; };

        # Мультимедиа
        "XF86AudioRaiseVolume" = { allow-when-locked = true; action.spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"; };
        "XF86AudioLowerVolume" = { allow-when-locked = true; action.spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"; };
        "XF86AudioMute" = { allow-when-locked = true; action.spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"; };
        "XF86AudioMicMute" = { allow-when-locked = true; action.spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"; };
        "XF86AudioPlay" = { allow-when-locked = true; action.spawn-sh = "playerctl play-pause"; };
        "XF86AudioStop" = { allow-when-locked = true; action.spawn-sh = "playerctl stop"; };
        "XF86AudioPrev" = { allow-when-locked = true; action.spawn-sh = "playerctl previous"; };
        "XF86AudioNext" = { allow-when-locked = true; action.spawn-sh = "playerctl next"; };
        "XF86MonBrightnessUp" = { allow-when-locked = true; action.spawn = [ "brightnessctl" "--class=backlight" "set" "+10%" ]; };
        "XF86MonBrightnessDown" = { allow-when-locked = true; action.spawn = [ "brightnessctl" "--class=backlight" "set" "10%-" ]; };

        # Скриншоты
        "Print" = { action.screenshot = {}; };
        "Mod+Print" = { action.spawn-sh = "grim - | wl-copy"; };
        "Ctrl+Print" = { action.spawn-sh = "grim -g \"$(slurp)\" - | satty --filename - --fullscreen --floating-hack --copy-command wl-copy"; };
      };
      
      # === ПРАВИЛА ОКОН ===
      window-rules = [
        # Скругленные углы для всех
        {
          geometry-corner-radius = let r = 15.0; in {
            top-left = r;
            top-right = r;
            bottom-left = r;
            bottom-right = r;
          };
          clip-to-geometry = true;
        }
        # PiP для LibreWolf
        {
          matches = [ { app-id = "^librewolf$"; title = "^Picture-in-Picture$"; } ];
          open-floating = true;
        }
        # Рабочий стол 1
        { matches = [ { app-id = "v2rayN"; } ]; open-on-workspace = "main"; }
        { matches = [ { app-id = "Telegram"; } ]; open-on-workspace = "main"; }
        # Рабочий стол 2
        { matches = [ { app-id = "librewolf"; } ]; open-on-workspace = "two"; }
        { matches = [ { app-id = "nvim"; } ]; open-on-workspace = "two"; }
      ];    
    };
  };
  # === ПОДКЛЮЧЕНИЕ NOCTALIA.KDL ===
  # 0. Очищаем потенциально измененный файл ДО проверок Home Manager
  home.activation.cleanupNiriConfig = lib.hm.dag.entryBefore ["checkLinkTargets"] ''
    FILE="${config.xdg.configHome}/niri/config.kdl"
    if [ -e "$FILE" ] && [ ! -L "$FILE" ]; then
      rm -f "$FILE"
    fi
  '';

  # 1. Запускаем скрипт ПОСЛЕ создания симлинков (linkGeneration)
  home.activation.appendNoctaliaInclude = lib.hm.dag.entryAfter ["linkGeneration"] ''
    FILE="${config.xdg.configHome}/niri/config.kdl"
    if [ -e "$FILE" ]; then
      # Превращаем симлинк в реальный файл
      if [ -L "$FILE" ]; then
        cp -L "$FILE" "$FILE.tmp"
        rm "$FILE"
        mv "$FILE.tmp" "$FILE"
      fi
      
      # Даём права на запись
      chmod u+w "$FILE"
      
      # Добавляем include В КОНЕЦ файла (с переносом строки), если его еще нет
      if ! grep -q 'include "./noctalia.kdl"' "$FILE"; then
        printf '\ninclude "./noctalia.kdl"\n' >> "$FILE"
      fi
    fi
  '';
}
