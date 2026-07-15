{ ... }:

{
  xdg.configFile."nvim/lua/config/keymaps.lua".text = ''
    -- Здесь можно добавить свои бинды
    -- Пример:
    -- vim.keymap.set("n", "<leader>ww", "<cmd>w<cr>", { desc = "Save file" })
  '';
}
