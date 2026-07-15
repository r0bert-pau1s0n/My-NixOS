{ ... }:

{
  programs.git = {
    enable = true;
    
    # Имя и почта для коммитов
    userName = "r0bert-pau1s0n";
    userEmail = "287035553+r0bert-pau1s0n@users.noreply.github.com";

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
      init.defaultBranch = "main";
      pull.rebase = false; # При pull создавать merge-коммиты
    };
  };
}
