{ ... }:

{
  xdg.configFile."nvim/lua/config/options.lua".text = ''
    -- Здесь можно задать свои опции, они перекроют опции LazyVim
    -- Пример:
    -- vim.opt.relativenumber = false
  '';
}
