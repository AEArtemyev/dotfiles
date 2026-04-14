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

local function switch_to_english()
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
end

-- автоматическая смена языка на английский при выходе из Insert Mode
-- и при возврате фокуса в Neovim из другого приложения
vim.api.nvim_create_autocmd({ "InsertLeave", "FocusGained" }, {
  callback = switch_to_english,
})

-- Переопределяем normal-mode команду `r`, чтобы после замены одного символа
-- раскладка сразу возвращалась на английскую.
vim.keymap.set("n", "r", function()
  -- `vim.v.count1` берёт числовой префикс перед командой.
  -- Если префикса нет, значение равно 1.
  -- Примеры: в `rX` будет 1, в `3rX` будет 3.
  local count = vim.v.count1

  -- `vim.fn.getcharstr()` ждёт ввод следующего символа от пользователя
  -- и возвращает его как строку. Здесь это символ, которым нужно заменить текст.
  local char = vim.fn.getcharstr()

  -- `vim.cmd.normal(...)` выполняет обычную normal-mode команду так,
  -- как будто мы ввели её вручную.
  vim.cmd.normal({
    -- `args` — список аргументов для команды `:normal`.
    -- Здесь передаём одну строку с готовой normal-командой, например `rA` или `3rx`.
    -- `string.format(...)` собирает эту строку по шаблону:
    -- `%d` подставляет число из `count`, `%s` подставляет строку из `char`.
    args = { string.format("%dr%s", count, char) },
    -- `bang = true` означает выполнение `:normal!`, а не просто `:normal`.
    -- Вариант с `!` игнорирует пользовательские remap-ы и запускает встроенную команду `r`.
    bang = true,
  })

  -- После замены символа принудительно возвращаем английскую раскладку.
  switch_to_english()
end, { desc = "Replace one character and switch layout to English" })
