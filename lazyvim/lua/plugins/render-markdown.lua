-- ~/.config/nvim/lua/plugins/render-markdown.lua
return {
  {
    "MeanderingProgrammer/render-markdown.nvim",

    opts = {
      enabled = true,

      -- Формулы рендерит Snacks.image
      latex = {
        enabled = false,
      },
    },

    keys = {
      {
        "<leader>mt",
        "<cmd>RenderMarkdown buf_toggle<cr>",
        ft = "markdown",
        desc = "Toggle Markdown render",
      },
      -- код слева, рендер справа
      {
        "<leader>mp",
        "<cmd>RenderMarkdown preview<cr>",
        ft = "markdown",
        desc = "Markdown preview split",
      },
    },
  },
}
