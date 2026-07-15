{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    settings = {
      # Шрифты
      font_size = "12";
      font_family = "JetBrainsMono Nerd Font";
      bold_font = "JetBrainsMono Nerd Font Bold";
      italic_font = "JetBrainsMono Nerd Font Italic";
      bold_italic_font = "JetBrainsMono Nerd Font Bold Italic";

      # Окно и курсор
      confirm_os_window_close = "0";
      cursor_shape = "beam";
      cursor_trail = "1";
      window_padding_width = "5 10 2";
      
      # Графика
      enable_graphics = "yes";
    };

    extraConfig = ''
      map ctrl+shift+с copy_to_clipboard
      map ctrl+shift+м paste_from_clipboard
      map ctrl+backspace send_text all \x17
      map ctrl+shift+a select_all
      map ctrl+shift+g kitten kitty_grab/grab.py

      include ~/.config/kitty/themes/noctalia.conf
    '';
  };
}
