{ ... }:

{
  programs = {
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    bat = {
      enable = true;
      config = {
        theme = "base16"; # Тема для подсветки синтаксиса
        style = "numbers,changes,header";
      };
    };
  };
}
