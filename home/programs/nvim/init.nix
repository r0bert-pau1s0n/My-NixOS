{ ... }:

{
  xdg.configFile."nvim/init.lua".text = ''
    -- bootstrap lazy.nvim, LazyVim and your plugins
    require("config.lazy")
    require("matugen").setup()
  '';
}
