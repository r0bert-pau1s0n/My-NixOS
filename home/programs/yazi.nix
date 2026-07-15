{ ... }:

{
  # Устанавливаем Yazi и включаем интеграцию с Zsh
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
  };

  # === yazi.toml ===
  xdg.configFile."yazi/yazi.toml".text = ''
    [mgr]
    ratio = [1, 4, 3]
    sort_by = "natural"
    sort_sensitive = false
    sort_reverse = false
    sort_dir_first = true
    linemode = "none"
    show_hidden = true
    show_symlink = true
    scrolloff = 8
    mouse_events = ["click", "scroll"]
    title_format = "Yazi"

    [preview]
    tab_size = 4
    max_width = 1600
    max_height = 2000
    cache_dir = ""

    [opener]
    edit = [
        { run = 'code --reuse-window %s', orphan = true, desc = "VS Code", for = "unix" },
    ]
    open = [
        { run = 'xdg-open %s', orphan = true, desc = "Open", for = "linux" },
    ]
    reveal = [
        { run = 'xdg-open "$(dirname %s)"', orphan = true, desc = "Reveal", for = "linux" },
    ]
    extract = [
        { run = 'ya pub extract --list %s', desc = "Extract here", for = "unix" },
    ]
    play = [
        { run = 'mpv %s', orphan = true, for = "unix" },
    ]

    [open]
    prepend_rules = [
        { mime = "text/*", use = [ "edit" ] },
        { url = "*.rs", use = [ "edit" ] },
        { url = "*.py", use = [ "edit" ] },
        { url = "*.js", use = [ "edit" ] },
        { url = "*.ts", use = [ "edit" ] },
        { url = "*.tsx", use = [ "edit" ] },
        { url = "*.jsx", use = [ "edit" ] },
        { url = "*.json", use = [ "edit" ] },
        { url = "*.toml", use = [ "edit" ] },
        { url = "*.yaml", use = [ "edit" ] },
        { url = "*.yml", use = [ "edit" ] },
        { url = "*.md", use = [ "edit" ] },
        { url = "*.c", use = [ "edit" ] },
        { url = "*.cpp", use = [ "edit" ] },
        { url = "*.h", use = [ "edit" ] },
        { url = "*.hpp", use = [ "edit" ] },
        { mime = "application/{gzip,bzip*,xz,zstd,zip,tar,rar,7z-compressed}", use = [ "extract" ] },
        { mime = "video/*", use = [ "play", "open" ] },
        { mime = "audio/*", use = [ "play", "open" ] },
        { mime = "image/*", use = [ "open" ] },
        { mime = "application/pdf", use = [ "open" ] },
        { url = "*", use = [ "open" ] },
    ]
  '';

  # === keymap.toml ===
  xdg.configFile."yazi/keymap.toml".text = ''
    [mgr]
    prepend_keymap = [
        { on = [ "h" ], run = "leave", desc = "Parent directory" },
        { on = [ "р" ], run = "leave", desc = "Parent directory RU" },
        { on = [ "l" ], run = "enter", desc = "Enter directory" },
        { on = [ "д" ], run = "enter", desc = "Enter directory RU" },
        { on = [ "j" ], run = "arrow 1", desc = "Down" },
        { on = [ "о" ], run = "arrow 1", desc = "Down RU" },
        { on = [ "k" ], run = "arrow -1", desc = "Up" },
        { on = [ "л" ], run = "arrow -1", desc = "Up RU" },
        { on = [ "g", "g" ], run = "arrow top", desc = "Top" },
        { on = [ "п", "п" ], run = "arrow top", desc = "Top RU" },
        { on = [ "G" ], run = "arrow bot", desc = "Bottom" },
        { on = [ "П" ], run = "arrow bot", desc = "Bottom RU" },
        { on = [ "<C-u>" ], run = "arrow -50%", desc = "Page up" },
        { on = [ "<C-d>" ], run = "arrow 50%", desc = "Page down" },
        { on = [ "<Enter>" ], run = "open", desc = "Open file" },
        { on = [ "o" ], run = "open", desc = "Open default" },
        { on = [ "щ" ], run = "open", desc = "Open default RU" },
        { on = [ "O" ], run = "open --interactive", desc = "Open with..." },
        { on = [ "Щ" ], run = "open --interactive", desc = "Open with RU" },
        { on = [ "e" ], run = "open", desc = "Open in VS Code" },
        { on = [ "у" ], run = "open", desc = "Open in VS Code RU" },
        { on = [ "." ], run = "hidden toggle", desc = "Toggle hidden files" },
        { on = [ "<Space>" ], run = "toggle", desc = "Toggle selection" },
        { on = [ "v" ], run = "visual_mode", desc = "Visual mode" },
        { on = [ "м" ], run = "visual_mode", desc = "Visual mode RU" },
        { on = [ "V" ], run = "visual_mode --unset", desc = "Clear selection" },
        { on = [ "М" ], run = "visual_mode --unset", desc = "Clear selection RU" },
        { on = [ "<Esc>" ], run = "escape", desc = "Cancel selection/search" },
        { on = [ "A" ], run = "toggle_all --state=on", desc = "Select all" },
        { on = [ "Ф" ], run = "toggle_all --state=on", desc = "Select all RU" },
        { on = [ "y" ], run = "yank", desc = "Copy files" },
        { on = [ "н" ], run = "yank", desc = "Copy files RU" },
        { on = [ "x" ], run = "yank --cut", desc = "Cut files" },
        { on = [ "ч" ], run = "yank --cut", desc = "Cut files RU" },
        { on = [ "p" ], run = "paste", desc = "Paste files" },
        { on = [ "з" ], run = "paste", desc = "Paste files RU" },
        { on = [ "d" ], run = "remove", desc = "Delete selected" },
        { on = [ "в" ], run = "remove", desc = "Delete selected RU" },
        { on = [ "a" ], run = "create", desc = "Create file/folder" },
        { on = [ "ф" ], run = "create", desc = "Create file/folder RU" },
        { on = [ "r" ], run = "rename --cursor=before_ext", desc = "Rename file" },
        { on = [ "к" ], run = "rename --cursor=before_ext", desc = "Rename file RU" },
        { on = [ "c", "c" ], run = "copy path", desc = "Copy file path" },
        { on = [ "с", "с" ], run = "copy path", desc = "Copy file path RU" },
        { on = [ "c", "d" ], run = "copy dirname", desc = "Copy directory path" },
        { on = [ "с", "в" ], run = "copy dirname", desc = "Copy directory path RU" },
        { on = [ "c", "f" ], run = "copy filename", desc = "Copy filename" },
        { on = [ "с", "а" ], run = "copy filename", desc = "Copy filename RU" },
        { on = [ "c", "n" ], run = "copy name_without_ext", desc = "Copy filename without extension" },
        { on = [ "с", "т" ], run = "copy name_without_ext", desc = "Copy filename without extension RU" },
        { on = [ "C" ], run = "plugin ouch", desc = "Compress with ouch" },
        { on = [ "С" ], run = "plugin ouch", desc = "Compress with ouch RU" },
        { on = [ "/" ], run = "find --smart", desc = "Search files" },
        { on = [ "n" ], run = "find_arrow", desc = "Next result" },
        { on = [ "т" ], run = "find_arrow", desc = "Next result RU" },
        { on = [ "N" ], run = "find_arrow --previous", desc = "Previous result" },
        { on = [ "Т" ], run = "find_arrow --previous", desc = "Previous result RU" },
        { on = [ ",", "n" ], run = "sort natural --dir-first", desc = "Natural sort" },
        { on = [ ",", "т" ], run = "sort natural --dir-first", desc = "Natural sort RU" },
        { on = [ ",", "m" ], run = "sort modified --reverse --dir-first", desc = "Modified sort" },
        { on = [ ",", "ь" ], run = "sort modified --reverse --dir-first", desc = "Modified sort RU" },
        { on = [ ",", "s" ], run = "sort size --reverse --dir-first", desc = "Size sort" },
        { on = [ ",", "ы" ], run = "sort size --reverse --dir-first", desc = "Size sort RU" },
        { on = [ ",", "e" ], run = "sort extension --dir-first", desc = "Extension sort" },
        { on = [ ",", "у" ], run = "sort extension --dir-first", desc = "Extension sort RU" },
        { on = [ "t" ], run = "tab_create --current", desc = "New tab" },
        { on = [ "е" ], run = "tab_create --current", desc = "New tab RU" },
        { on = [ "W" ], run = "close", desc = "Close tab" },
        { on = [ "Ц" ], run = "close", desc = "Close tab RU" },

        { on = [ "[" ], run = "tab_switch -1", desc = "Previous tab" },
        { on = [ "]" ], run = "tab_switch 1", desc = "Next tab" },
        { on = [ "1" ], run = "tab_switch 0", desc = "Tab 1" },
        { on = [ "2" ], run = "tab_switch 1", desc = "Tab 2" },
        { on = [ "3" ], run = "tab_switch 2", desc = "Tab 3" },
        { on = [ "4" ], run = "tab_switch 3", desc = "Tab 4" },
        { on = [ "g", "c" ], run = "cd ~/.config", desc = "Go to config" },
        { on = [ "п", "с" ], run = "cd ~/.config", desc = "Go to config RU" },
        { on = [ "g", "k" ], run = "cd ~/.cache", desc = "Go to cache" },
        { on = [ "п", "л" ], run = "cd ~/.cache", desc = "Go to cache RU" },
        { on = [ "g", "d" ], run = "cd ~/Downloads", desc = "Go to Downloads" },
        { on = [ "п", "в" ], run = "cd ~/Downloads", desc = "Go to Downloads RU" },
        { on = [ ";" ], run = 'shell "$SHELL" --block', desc = "Open shell here" },
        { on = [ ":" ], run = "shell --block", desc = "Run shell command" },
        { on = [ "<C-z>" ], run = "suspend", desc = "Suspend Yazi" },
        { on = [ "i" ], run = "peek", desc = "Preview file" },
        { on = [ "ш" ], run = "peek", desc = "Preview file RU" },
        { on = [ "R" ], run = "refresh", desc = "Refresh directory" },
        { on = [ "К" ], run = "refresh", desc = "Refresh directory RU" },
        { on = [ "?" ], run = "help", desc = "Help" },
        { on = [ "q" ], run = "quit", desc = "Quit Yazi" },
        { on = [ "й" ], run = "quit", desc = "Quit Yazi RU" },
        { on = [ "Q" ], run = "quit --no-cwd-file", desc = "Force quit" },
        { on = [ "Й" ], run = "quit --no-cwd-file", desc = "Force quit RU" },
    ]
  '';

  # === package.toml ===
  xdg.configFile."yazi/package.toml".text = ''
    [[plugin.deps]]
    use = "ndtoan96/ouch"
    rev = "406ce6c"
    hash = "f5afc904d5106ee368c8aa2ded43bd74"

    [flavor]
    deps = []
  '';

  # === theme.toml ===
  xdg.configFile."yazi/theme.toml".text = ''
    [flavor]
    dark  = "noctalia"
    light = "noctalia"
  '';
}
