{ ... }:

{
  xdg.configFile."nvim/init.lua".text = ''
    -- bootstrap lazy.nvim, LazyVim and your plugins
    require("config.lazy")

    -- Noctalia генерирует lua/matugen.lua при первом применении темы.
    -- До этого модуль может отсутствовать — не роняем запуск Neovim.
    -- Глотаем только "module not found", прочие ошибки пробрасываем.
    local ok, matugen = pcall(require, "matugen")
    if ok then
      matugen.setup()
    elseif not tostring(matugen):match("module 'matugen' not found") then
      error(matugen)
    end
  '';
}
