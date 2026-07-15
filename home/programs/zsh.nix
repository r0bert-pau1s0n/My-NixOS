{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;

    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [ "git" "sudo" "colored-man-pages" "command-not-found" ];
    };

    plugins = [
      {
        name = "fast-syntax-highlighting";
        src = pkgs.zsh-fast-syntax-highlighting;
        file = "share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh";
      }
    ];

    shellAliases = {
      ll = "ls -l";
      la = "ls -a";
      # Одна команда обновляет и систему, и Home Manager
      update = "sudo nixos-rebuild switch --flake ~/nix#nixos";
      cleanup = "sudo nix-collect-garbage -d";
    };

    # Заменили initExtra на initContent
    initContent = ''
      HISTSIZE=10000
      SAVEHIST=10000
      setopt HIST_IGNORE_DUPS
    '';
  };
}
