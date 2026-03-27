-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

-- Вертикальная линия на 80 символе
opt.colorcolumn = "80"
-- отображение невидимых символов (табы, пробелы и т.п.)
opt.list = true
opt.listchars = "space:·"
-- Перенос длинных строк на несколько визуальных строк.
opt.wrap = true

-- автоматическая смена языка на английский при выходе из Insert Mode
vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function()
    vim.fn.jobstart({
      "gdbus",
      "call",
      "--session",
      "--dest",
      "org.gnome.Shell",
      "--object-path",
      "/me/madhead/Shyriiwook",
      "--method",
      "me.madhead.Shyriiwook.activate",
      "us",
    }, { detach = true })
  end,
})
