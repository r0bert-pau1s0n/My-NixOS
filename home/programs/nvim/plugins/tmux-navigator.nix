{ ... }:

{
  xdg.configFile."nvim/lua/plugins/tmux-navigator.lua".text = ''
    return {
      "christoomey/vim-tmux-navigator",
      keys = {
        { "<C-h>", "<cmd>TmuxNavigateLeft<cr>", desc = "Window Left" },
        { "<C-j>", "<cmd>TmuxNavigateDown<cr>", desc = "Window Down" },
        { "<C-k>", "<cmd>TmuxNavigateUp<cr>", desc = "Window Up" },
        { "<C-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Window Right" },
      },
      lazy = false,
    }
  '';
}
