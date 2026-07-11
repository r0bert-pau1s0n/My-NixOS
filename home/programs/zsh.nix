# ~/nix/home/programs/zsh.nix
{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    
    # Включаем встроенное автодополнение (это и есть zsh-autosuggestions)
    autosuggestion.enable = true;

    # Настройка Oh My Zsh
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell"; # Можете поменять на любую другую
      plugins = [
        "git"
        "sudo"
        "colored-man-pages"
        "command-not-found"
      ];
    };

    # Подключение сторонних плагинов (fast-syntax-highlighting)
    plugins = [
      {
        name = "fast-syntax-highlighting";
        src = pkgs.zsh-fast-syntax-highlighting;
        file = "share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh";
      }
    ];

    # Пользовательские алиасы
    shellAliases = {
      ll = "ls -l";
      la = "ls -a";
      update = "sudo nixos-rebuild switch --flake ~/nix#nixos";
      homeup = "home-manager switch --flake ~/nix#robert";
      cleanup = "sudo nix-collect-garbage -d";
    };

    # Дополнительные настройки
    initExtra = ''
      # История команд
      HISTSIZE=10000
      SAVEHIST=10000
      setopt HIST_IGNORE_DUPS
    '';
  };
}
