-- ~/.config/nvim/lua/plugins/snacks.lua
return {
  {
    "folke/snacks.nvim",

    opts = {
      lazygit = {
        env = {
          -- Команда C запускает git commit, который ждёт завершения GIT_EDITOR.
          -- NVIM_APPNAME=lazyvim наследуется от lv, поэтому откроется LazyVim.
          GIT_EDITOR = "nvim",
        },
      },
      image = {
        enabled = true,
        math = {
          enabled = true,
        },
      },
    },

    keys = {
      {
        "<leader>mu",
        function()
          local math = Snacks.image.config.math
          math.enabled = not math.enabled

          local buf = vim.api.nvim_get_current_buf()

          -- Обновить inline-изображения и формулы.
          pcall(vim.api.nvim_exec_autocmds, "WinScrolled", {
            buffer = buf,
            modeline = false,
          })

          -- Обновить floating/hover preview, если он используется.
          pcall(vim.api.nvim_exec_autocmds, "CursorMoved", {
            buffer = buf,
            modeline = false,
          })

          vim.notify(("Snacks math: %s"):format(math.enabled and "enabled" or "disabled"))
        end,

        ft = { "markdown", "tex" },
        desc = "Toggle Snacks math",
      },
    },
  },
}
