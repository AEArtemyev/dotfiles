return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.inlay_hints.enabled = false
      -- log=error уменьшает количество выводимой инфорации в stderr; neovim
      -- пишет эту информацию в лог файл из-за чего файл сильно разрастается
      -- clang-tidy включает clang-tidy, рядом должен быть файл .clang-tidy.
      -- background-index включает фоновую индексацию
      table.insert(opts.servers.clangd.cmd, "--log=error --clang-tidy --background-index")
    end,
  },
}
