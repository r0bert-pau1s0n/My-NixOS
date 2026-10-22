{ pkgs, ... }:

{
  xdg.configFile."tmux/tmux.conf".force = true;

  programs.tmux = {
    enable = true;
    shortcut = "a"; # Использовать Ctrl+a вместо Ctrl+b (удобнее нажимать)
    baseIndex = 1; # Нумерация окон начинается с 1 (а не с 0)
    mouse = true; # Включить поддержку мыши (скролл, клики по панелям)
    keyMode = "vi"; # Vi-подобные горячие клавиши для копирования и навигации
    terminal = "tmux-256color"; # Корректная поддержка 256 цветов

    # Агрессивное изменение размера окна (полезно при работе с несколькими клиентами)
    aggressiveResize = true;

    # Плагины tmux (ставятся через Nix)
    plugins = with pkgs.tmuxPlugins; [
      sensible # Набор базовых улучшений "из коробки"
      yank # Копирование из tmux в системный буфер обмена (wl-clipboard)
      vim-tmux-navigator # Удобное перемещение между панелями tmux и окнами Neovim (Ctrl+hjkl)
    ];

    extraConfig = ''
      # Поддержка True Colors (24-бит) для корректного отображения тем (Kanagawa/Noctalia)
      set -ga terminal-overrides ",xterm-256color:Tc"

      # Открытие новых панелей и окон в текущей директории
      bind '"' split-window -v -c "#{pane_current_path}"
      bind '%' split-window -h -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"

      # Изменение размера панелей (Префикс + Shift + h/j/k/l)
      # -r означает, что команду можно повторять без нажатия префикса
      bind -r H resize-pane -L 5
      bind -r J resize-pane -D 5
      bind -r K resize-pane -U 5
      bind -r L resize-pane -R 5

      # Визуальное оформление панели статуса (нижняя полоса)
      set -g status-position bottom
      set -gq @noctalia_primary "#7e9cd8"
      set -gq @noctalia_on_surface_variant "#d8e5e9"
      set -g status-style "bg=default, fg=#7e9cd8"
      set -g status-left "#[fg=#{@noctalia_primary},bold] #S "
      set -g status-right "#[fg=#{@noctalia_on_surface_variant}]%H:%M "
      set -g window-status-current-style "fg=#1f1f28, bg=#7e9cd8, bold"
      set -g window-status-current-format " #I:#W "
      set -g window-status-format " #I:#W "

      source-file -q "$HOME/.config/tmux/themes/noctalia.conf"
    '';
  };
}
