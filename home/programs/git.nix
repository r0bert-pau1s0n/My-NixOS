{ ... }:

{
  programs.git = {
    enable = true;
    
    # Имя и почта для коммитов
    userName = "Robert Paulson";
    userEmail = "r0bert-pau1s0n@users.noreply.github.com";

    # Цвета в терминале
    delta.enable = true; # Красивый diff при просмотре изменений

    # Алиасы (сокращения команд)
    aliases = {
      st = "status";
      co = "checkout";
      br = "branch";
      ci = "commit";
      lg = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %s %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all";
    };

    # Базовые настройки
    extraConfig = {
      init.defaultBranch = "master";
      pull.rebase = false; # При pull создавать merge-коммиты
    };
  };
}
