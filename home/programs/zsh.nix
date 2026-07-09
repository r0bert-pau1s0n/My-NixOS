# ~/nix/home/programs/zsh.nix
{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    
    # Включаем автодополнение (аналог плагина zsh-autosuggestions)
    autosuggestion.enable = true;
    
    # Включаем подсветку синтаксиса (аналог плагина zsh-syntax-highlighting)
    syntaxHighlighting.enable = true;

    # Настройка Oh My Zsh
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell"; # Можете поменять на любую другую, например "agnoster"
      
      # ВСТРОЕННЫЕ плагины Oh My Zsh (без дополнительных установок)
      plugins = [
        "git"
        "sudo"        # Двойной ESC добавляет sudo перед командой
        "colored-man-pages"
        "command-not-found"
        # Добавляйте сюда любые стандартные плагины OMZ
      ];
    };

    # Пользовательские алиасы
    shellAliases = {
      ll = "ls -l";
      la = "ls -a";
      update = "sudo nixos-rebuild switch --flake ~/nix#nixos";
      homeup = "home-manager switch --flake ~/nix#robert";
      cleanup = "sudo nix-collect-garbage -d";
    };

    # Дополнительные настройки (история, ключи и т.д.)
    initExtra = ''
      # История команд
      HISTSIZE=10000
      SAVEHIST=10000
      setopt HIST_IGNORE_DUPS
    '';
  };
}
