-- ~/.config/nvim/lua/plugins/colorscheme.lua
return {
  -- Добавляем тему Kanagawa
  {
    "rebelot/kanagawa.nvim",
    lazy = false, -- загружать сразу, а не по требованию
    priority = 1000, -- загружать до других плагинов
    config = function()
      -- Загружаем тему с настройками по умолчанию
      require("kanagawa").load()

      -- Или можно настроить её предварительно:
      -- require("kanagawa").setup({
      --   -- Ваши настройки здесь (см. раздел ниже)
      -- })
      -- vim.cmd("colorscheme kanagawa")
    end,
  },
}
