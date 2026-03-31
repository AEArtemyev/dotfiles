-- Переопределяем fold-настройки после ftplugin из matlab.nvim,
-- потому что сам плагин принудительно выставляет foldmethod=manual.
vim.opt_local.foldmethod = "expr"
vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt_local.foldlevelstart = 99
vim.opt_local.foldnestmax = 6
vim.opt_local.foldenable = true
