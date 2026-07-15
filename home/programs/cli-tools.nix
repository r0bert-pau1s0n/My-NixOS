{ ... }:

{
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.bat = {
    enable = true;
    config = {
      theme = "base16"; # Тема для подсветки синтаксиса
      style = "numbers,changes,header";
    };
  };
}
