{ ... }:

{
  # Декларативный конфиг OpenCode TUI. Тема `system` встроена в OpenCode:
  # использует ANSI-цвета (0–15) и терминальные default-цвета (text/bg = none),
  # поэтому OpenCode перекрашивается вместе с палитрой kitty без перезапуска
  # (Noctalia перезагружает палитру kitty по SIGUSR1). `force` нужен, потому что
  # до этого tui.json был обычным файлом, а не управляемым Home Manager.
  xdg.configFile."opencode/tui.json" = {
    force = true;
    text = ''
      {
        "$schema": "https://opencode.ai/tui.json",
        "theme": "system"
      }
    '';
  };
}
