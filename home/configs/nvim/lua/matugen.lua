local M = {}

function M.setup()
  require("base16-colorscheme").setup({
    -- Background tones
    base00 = "#1f1f28", -- Default Background
    base01 = "#2a2a37", -- Lighter Background (status bars)
    base02 = "#333343", -- Selection Background
    base03 = "#676785", -- Comments, Invisibles
    -- Foreground tones
    base04 = "#717c7c", -- Dark Foreground (status bars)
    base05 = "#c8c093", -- Default Foreground
    base06 = "#c8c093", -- Light Foreground
    base07 = "#c8c093", -- Lightest Foreground
    -- Accent colors
    base08 = "#c34043", -- Variables, XML Tags, Errors
    base09 = "#7e9cd8", -- Integers, Constants
    base0A = "#c0a36e", -- Classes, Search Background
    base0B = "#76946a", -- Strings, Diff Inserted
    base0C = "#96b1e9", -- Regex, Escape Chars
    base0D = "#ade996", -- Functions, Methods
    base0E = "#e9cb96", -- Keywords, Storage
    base0F = "#430d0e", -- Deprecated, Embedded Tags
  })

  -- Эта магия сработает ПОСЛЕ того, как base16 применит цвета
  vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = function()
      local bg_main = "#1f1f28"
      local bg_title = "#2a2a37"
      local fg_main = "#c8c093"
      local fg_dim = "#717c7c"
      local border_color = "#676785"
      local primary = "#76946a"

      -- 1. Дашборд
      vim.api.nvim_set_hl(0, "SnacksDashboardHeader", { fg = primary })
      vim.api.nvim_set_hl(0, "SnacksDashboardDesc", { fg = fg_dim })
      vim.api.nvim_set_hl(0, "SnacksDashboardKey", { fg = "#c0a36e" })
      vim.api.nvim_set_hl(0, "SnacksDashboardIcon", { fg = "#7e9cd8" })
      vim.api.nvim_set_hl(0, "SnacksDashboardFooter", { fg = fg_dim })
    end,
  })
end

-- Обработчик сигнала от noctaliachell
local signal = vim.uv.new_signal()
signal:start(
  "sigusr1",
  vim.schedule_wrap(function()
    -- Сбрасываем кэш ЭТОГО файла
    package.loaded["matugen"] = nil
    -- Заново загружаем этот файл (noctaliachell уже заменил цвета в нем на диске)
    -- Теперь require вернет таблицу M, и .setup() отработает без ошибки
    require("matugen").setup()
  end)
)

-- <<< ВОТ ЭТОЙ СТРОКИ НЕ ХВАТАЛО! >>>
return M
