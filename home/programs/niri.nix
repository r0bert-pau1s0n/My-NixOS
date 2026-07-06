# ~/nix/home/programs/niri.nix
{ pkgs, ... }:

{
  programs.niri = {
    enable = true;
    
    settings = {
      # === НАЧАЛЬНЫЙ ЗАПУСК ===
      spawn-at-startup = [
        "xwayland-satellite"
        [ "sh" "-c" "sleep 2 && export DISPLAY=:0" ]
        "noctalia-shell"
        "v2rayN"
        [ "sh" "-c" "sleep 2 && Telegram" ]
        "librewolf"
        [ "sh" "-c" "sleep 2 && kitty --app-id nvim -e nvim" ]
      ];

      # === АНИМАЦИИ ===
      animations = {
        window-open = { spring = { damping-ratio = 1.0; stiffness = 600; epsilon = 0.001; }; };
        window-close = { spring = { damping-ratio = 1.0; stiffness = 500; epsilon = 0.001; }; };
        workspace-switch = { spring = { damping-ratio = 0.8; stiffness = 1000; epsilon = 0.001; }; };
        horizontal-view-movement = { spring = { damping-ratio = 0.8; stiffness = 1000; epsilon = 0.0001; }; };
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
        
        focus-ring = {
          width = 2;
          active-gradient = { from = "#89b4fa"; to = "#cba6f7"; angle = 135; };
          inactive-color = "#313244";
        };
        
        border = { enable = false; };
        
        shadow = {
          enable = true;
          draw-behind-window = true;
          softness = 20;
          spread = 2;
          offset = { x = 0; y = 3; };
          color = "#0005";
        };
      };

      # === РАБОЧИЕ СТОЛЫ ===
      workspaces = {
        "main" = {};
        "two" = {};
      };

      # === ГОРЯЧИЕ КЛАВИШИ (BINDES) ===
      keybindings = {
        # Система
        "Mod+Shift+Slash" = { show-hotkey-overlay = {}; };
        "Super+Alt+L" = { spawn = "swaylock"; hotkey-overlay-title = "Lock the Screen: swaylock"; };
        "Mod+Shift+P" = { power-off-monitors = {}; };
        "Mod+M" = { quit = {}; };
        "Ctrl+Alt+Delete" = { quit = {}; };
        "Mod+Escape" = { toggle-keyboard-shortcuts-inhibit = {}; allow-inhibiting = false; };

        # Запуск приложений
        "Mod+Return" = { spawn = "kitty"; hotkey-overlay-title = "Terminal: kitty"; };
        "Mod+T" = { spawn = "Telegram"; hotkey-overlay-title = "Telegram"; };
        "Mod+B" = { spawn = "librewolf"; hotkey-overlay-title = "LibreWolf"; };
        "Mod+N" = { spawn = [ "kitty" "--app-id" "nvim" "-e" "nvim" ]; hotkey-overlay-title = "Neovim"; };
        "Mod+X" = { spawn = "v2rayN"; hotkey-overlay-title = "V2RayN"; };
        "Mod+D" = { spawn = "code"; hotkey-overlay-title = "VS Code"; };
        "Mod+E" = { spawn = [ "kitty" "--app-id" "yazi" "-e" "yazi" ]; hotkey-overlay-title = "File Manager: Yazi"; };

        # Утилиты Noctalia
        "Mod+Y" = { spawn = [ "noctalia-shell" "ipc" "call" "controlCenter" "toggle" ]; hotkey-overlay-title = "Control Center: noctalia controlCenter"; };
        "Mod+R" = { spawn = [ "noctalia-shell" "ipc" "call" "launcher" "toggle" ]; hotkey-overlay-title = "Application Launcher: Noctalia"; };
        "Mod+V" = { spawn = [ "noctalia-shell" "ipc" "call" "plugin:clipboard" "toggle" ]; hotkey-overlay-title = "Clipboard History: Noctalia"; };
        "Mod+Shift+V" = { spawn = [ "noctalia-shell" "ipc" "call" "plugin:clipboard" "wipe" ]; hotkey-overlay-title = "Clipboard Wipe: Noctalia"; };
        "Mod+Shift+Q" = { spawn = [ "noctalia-shell" "ipc" "call" "sessionMenu" "toggle" ]; hotkey-overlay-title = "Session Menu: noctalia sessionMenu"; };

        # Фокус
        "Mod+H" = { focus-column-left = {}; };
        "Mod+L" = { focus-column-right = {}; };
        "Mod+Home" = { focus-column-first = {}; };
        "Mod+End" = { focus-column-last = {}; };
        "Mod+Ctrl+H" = { focus-monitor-left = {}; };
        "Mod+Ctrl+J" = { focus-monitor-down = {}; };
        "Mod+Ctrl+K" = { focus-monitor-up = {}; };
        "Mod+Ctrl+L" = { focus-monitor-right = {}; };

        # Перемещение
        "Mod+Shift+H" = { move-column-left = {}; };
        "Mod+Shift+J" = { move-window-down = {}; };
        "Mod+Shift+K" = { move-window-up = {}; };
        "Mod+Shift+L" = { move-column-right = {}; };
        "Mod+Ctrl+Home" = { move-column-to-first = {}; };
        "Mod+Ctrl+End" = { move-column-to-last = {}; };
        "Mod+Ctrl+Shift+H" = { move-column-to-monitor-left = {}; };
        "Mod+Ctrl+Shift+J" = { move-column-to-monitor-down = {}; };
        "Mod+Ctrl+Shift+K" = { move-column-to-monitor-up = {}; };
        "Mod+Ctrl+Shift+L" = { move-column-to-monitor-right = {}; };

        # Воркспейсы
        "Mod+J" = { focus-workspace-down = {}; };
        "Mod+K" = { focus-workspace-up = {}; };
        "Mod+Ctrl+U" = { move-column-to-workspace-down = {}; };
        "Mod+Ctrl+I" = { move-column-to-workspace-up = {}; };
        "Mod+Alt+U" = { move-workspace-down = {}; };
        "Mod+Alt+I" = { move-workspace-up = {}; };
        "Mod+1" = { focus-workspace = 1; };
        "Mod+2" = { focus-workspace = 2; };
        "Mod+3" = { focus-workspace = 3; };
        "Mod+4" = { focus-workspace = 4; };
        "Mod+5" = { focus-workspace = 5; };
        "Mod+6" = { focus-workspace = 6; };
        "Mod+7" = { focus-workspace = 7; };
        "Mod+8" = { focus-workspace = 8; };
        "Mod+9" = { focus-workspace = 9; };
        "Mod+0" = { focus-workspace = 10; };
        "Mod+Shift+1" = { move-column-to-workspace = 1; };
        "Mod+Shift+2" = { move-column-to-workspace = 2; };
        "Mod+Shift+3" = { move-column-to-workspace = 3; };
        "Mod+Shift+4" = { move-column-to-workspace = 4; };
        "Mod+Shift+5" = { move-column-to-workspace = 5; };
        "Mod+Shift+6" = { move-column-to-workspace = 6; };
        "Mod+Shift+7" = { move-column-to-workspace = 7; };
        "Mod+Shift+8" = { move-column-to-workspace = 8; };
        "Mod+Shift+9" = { move-column-to-workspace = 9; };
        "Mod+Shift+0" = { move-column-to-workspace = 10; };
        "Mod+Tab" = { focus-workspace-previous = {}; };

        # Колесо мыши
        "Mod+WheelScrollDown" = { focus-workspace-down = {}; cooldown-ms = 150; };
        "Mod+WheelScrollUp" = { focus-workspace-up = {}; cooldown-ms = 150; };
        "Mod+Ctrl+WheelScrollDown" = { move-column-to-workspace-down = {}; cooldown-ms = 150; };
        "Mod+Ctrl+WheelScrollUp" = { move-column-to-workspace-up = {}; cooldown-ms = 150; };
        "Mod+WheelScrollRight" = { focus-column-right = {}; };
        "Mod+WheelScrollLeft" = { focus-column-left = {}; };
        "Mod+Ctrl+WheelScrollRight" = { move-column-right = {}; };
        "Mod+Ctrl+WheelScrollLeft" = { move-column-left = {}; };
        "Mod+Shift+WheelScrollDown" = { focus-column-right = {}; };
        "Mod+Shift+WheelScrollUp" = { focus-column-left = {}; };
        "Mod+Ctrl+Shift+WheelScrollDown" = { move-column-right = {}; };
        "Mod+Ctrl+Shift+WheelScrollUp" = { move-column-left = {}; };

        # Размеры
        "Mod+Minus" = { set-column-width = "-10%"; };
        "Mod+Equal" = { set-column-width = "+10%"; };
        "Mod+Shift+Minus" = { set-window-height = "-10%"; };
        "Mod+Shift+Equal" = { set-window-height = "+10%"; };
        "Mod+Alt+R" = { switch-preset-column-width = {}; };
        "Mod+Alt+Shift+R" = { switch-preset-column-width-back = {}; };
        "Mod+Ctrl+Alt+Shift+R" = { switch-preset-window-height = {}; };
        "Mod+Ctrl+Alt+R" = { reset-window-height = {}; };

        # Состояния окон
        "Mod+Q" = { close-window = {}; };
        "Mod+F" = { maximize-column = {}; };
        "Mod+Shift+F" = { fullscreen-window = {}; };
        "Mod+Alt+F" = { toggle-window-floating = {}; };
        "Mod+Shift+M" = { maximize-window-to-edges = {}; };
        "Mod+Ctrl+F" = { expand-column-to-available-width = {}; };
        "Mod+C" = { center-column = {}; };
        "Mod+Ctrl+C" = { center-visible-columns = {}; };
        "Mod+S" = { toggle-overview = {}; repeat = false; };
        "Mod+Alt+W" = { toggle-column-tabbed-display = {}; };

        # Колонны
        "Mod+Less" = { consume-or-expel-window-left = {}; };
        "Mod+Greater" = { consume-or-expel-window-right = {}; };
        "Mod+Comma" = { consume-window-into-column = {}; };
        "Mod+Period" = { expel-window-from-column = {}; };

        # Мультимедиа
        "XF86AudioRaiseVolume" = { allow-when-locked = true; spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"; };
        "XF86AudioLowerVolume" = { allow-when-locked = true; spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"; };
        "XF86AudioMute" = { allow-when-locked = true; spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"; };
        "XF86AudioMicMute" = { allow-when-locked = true; spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"; };
        "XF86AudioPlay" = { allow-when-locked = true; spawn-sh = "playerctl play-pause"; };
        "XF86AudioStop" = { allow-when-locked = true; spawn-sh = "playerctl stop"; };
        "XF86AudioPrev" = { allow-when-locked = true; spawn-sh = "playerctl previous"; };
        "XF86AudioNext" = { allow-when-locked = true; spawn-sh = "playerctl next"; };
        "XF86MonBrightnessUp" = { allow-when-locked = true; spawn = [ "brightnessctl" "--class=backlight" "set" "+10%" ]; };
        "XF86MonBrightnessDown" = { allow-when-locked = true; spawn = [ "brightnessctl" "--class=backlight" "set" "10%-" ]; };

        # Скриншоты
        "Print" = { screenshot = {}; };
        "Mod+Print" = { spawn-sh = "grim - | wl-copy"; };
        "Ctrl+Print" = { spawn-sh = "grim -g \"$(slurp)\" - | satty --filename - --fullscreen --floating-hack --copy-command wl-copy"; };
      };

      # === ПРАВИЛА ОКОН ===
      window-rules = [
        # Скругленные углы для всех
        {
          geometry-corner-radius = 15;
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
}
