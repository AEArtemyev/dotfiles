return {
  -- add gruvbox
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "storm",
      styles = {
        comments = { italic = false },
      },
      on_colors = function(colors)
        colors.comment = "#00FF00"
      end,
      on_highlights = function(hl, c)
        hl.ColorColumn = { bg = "#7a7a7a" }
        hl.WinSeparator = { fg = "#FFFFFF" }
      end,
    },
  },
  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
}
