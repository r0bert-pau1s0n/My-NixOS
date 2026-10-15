{ ... }:

{
  programs.git = {
    enable = true;

    # Настройки (новый формат вместо userName/userEmail/extraConfig/aliases)
    settings = {
      # Имя и почта для коммитов
      user = {
        name = "r0bert-pau1s0n";
        email = "287035553+r0bert-pau1s0n@users.noreply.github.com";
      };

      # Алиасы (сокращения команд)
      alias = {
        st = "status";
        co = "checkout";
        br = "branch";
        ci = "commit";
        lg = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %s %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all";
      };

      # Базовые настройки
      init.defaultBranch = "main";
      pull.rebase = false; # При pull создавать merge-коммиты
    };
  };

  # Delta теперь отдельная опция
  programs.delta = {
    enable = true; # Красивый diff при просмотре изменений
    enableGitIntegration = true; # Теперь нужно указывать явно
  };
}
