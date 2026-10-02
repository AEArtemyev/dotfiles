return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      -- indent в matlab файлах будет контролироваться через
      -- vim.g.MATLAB_function_indent
      indent = {
        disable = { "matlab" },
      },
    },
  },
}
