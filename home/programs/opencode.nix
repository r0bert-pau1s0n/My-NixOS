{ ... }:

{
  # Декларативный конфиг OpenCode TUI. Тема `matugen` генерируется шаблоном
  # Noctalia в ~/.config/opencode/themes/matugen.json при каждой смене палитры.
  # OpenCode 1.19 не следит за файлами: он перечитывает кастомные темы только по
  # SIGUSR2 (ThemeProvider -> themeSource.subscribeRefresh). Этот сигнал шлёт хук
  # Noctalia colors_changed (см. noctalia.nix), поэтому тема обновляется вживую
  # без перезапуска и без потери сессии. `force` нужен, потому что до этого
  # tui.json был обычным файлом, а не управляемым Home Manager.
  xdg.configFile."opencode/tui.json" = {
    force = true;
    text = ''
      {
        "$schema": "https://opencode.ai/tui.json",
        "theme": "matugen"
      }
    '';
  };
}
