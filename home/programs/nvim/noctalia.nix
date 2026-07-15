{ ... }:

{
  # Создаем файл-шаблон для Noctalia прямо в папке nvim
  xdg.configFile."nvim/lua/matugen-template.lua".text = ''
    local M = {}

    function M.setup()
      local ok_base16, base16 = pcall(require, "base16-colorscheme")
      if not ok_base16 then
        return
      end

      base16.setup({
        base00 = "{{colors.surface.default.hex}}",
        base01 = "{{colors.surface_container.default.hex}}",
        base02 = "{{colors.surface_container_high.default.hex}}",
        base03 = "{{colors.outline.default.hex}}",
        base04 = "{{colors.on_surface_variant.default.hex}}",
        base05 = "{{colors.on_surface.default.hex}}",
        base06 = "{{colors.on_surface.default.hex}}",
        base07 = "{{colors.on_background.default.hex}}",
        base08 = "{{colors.error.default.hex}}",
        base09 = "{{colors.tertiary.default.hex}}",
        base0A = "{{colors.secondary.default.hex}}",
        base0B = "{{colors.primary.default.hex}}",
        base0C = "{{colors.tertiary_fixed_dim.default.hex}}",
        base0D = "{{colors.primary_fixed_dim.default.hex}}",
        base0E = "{{colors.secondary_fixed_dim.default.hex}}",
        base0F = "{{colors.error_container.default.hex}}",
      })

      -- Функция для применения кастомных цветов поверх плагинов
      local apply_custom_highlights = function()
        local primary = "{{colors.primary.default.hex}}"
        local fg_dim = "{{colors.on_surface_variant.default.hex}}"

        vim.api.nvim_set_hl(0, "SnacksDashboardHeader", { fg = primary })
        vim.api.nvim_set_hl(0, "SnacksDashboardDesc", { fg = fg_dim })
        vim.api.nvim_set_hl(0, "SnacksDashboardKey", { fg = "{{colors.secondary.default.hex}}" })
        vim.api.nvim_set_hl(0, "SnacksDashboardIcon", { fg = "{{colors.tertiary.default.hex}}" })
        vim.api.nvim_set_hl(0, "SnacksDashboardFooter", { fg = fg_dim })
      end

      -- Применяем сразу
      apply_custom_highlights()

      -- И применяем каждый раз при смене темы (для сигнала SIGUSR1)
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = apply_custom_highlights,
      })
    end

    -- Обработчик сигнала от noctaliachell
    local signal = vim.uv.new_signal()
    signal:start(
      "sigusr1",
      vim.schedule_wrap(function()
        package.loaded["matugen"] = nil
        local ok, mod = pcall(require, "matugen")
        if ok and mod then
          mod.setup()
        end
      end)
    )

    return M
  '';
}
