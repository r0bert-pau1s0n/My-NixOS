{ ... }:

{
  xdg.configFile."nvim/lua/plugins/kanagawa.lua".text = ''
    return {
      {
        "rebelot/kanagawa.nvim",
        lazy = false,
        priority = 1000,
        config = function()
          require("kanagawa").load()
        end,
      },
    }
  '';

  xdg.configFile."nvim/lua/plugins/base16.lua".text = ''
    return {
      {
        "RRethy/base16-nvim",
        priority = 1000,
        lazy = false,
      }
    }
  '';
}
