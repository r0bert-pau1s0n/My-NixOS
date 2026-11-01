{ ... }:

{
  programs.btop = {
    enable = true;

    settings = {
      color_theme = "noctalia";
      theme_background = true;
      truecolor = true;
    };
  };

  xdg.configFile."btop/btop.conf".force = true;
}
