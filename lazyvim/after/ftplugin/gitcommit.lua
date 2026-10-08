-- Как создать коммит через редактор LazyVim:
-- 1. Откройте lazygit и добавьте нужные изменения в индекс (stage).
-- 2. В панели Files нажмите заглавную C (Shift+c).
-- 3. Напишите краткое сообщение, оставьте пустую строку и добавьте подробное
--    описание. В режиме вставки Enter добавляет новую строку.
-- 4. Нажмите Esc, затем введите :wq для коммита или :cq для отмены
--    и нажмите Enter.
-- Редактор использует конфигурацию LazyVim и переключает раскладку на английскую
-- при выходе из режима вставки или закрытии редактора сообщения коммита.
--
-- Этот файл загружается только для буферов с сообщением коммита.
-- Выход из режима вставки обрабатывается в config/options.lua; здесь
-- обрабатываем уход из буфера и завершение редактора.
local group = vim.api.nvim_create_augroup("lazyvim_gitcommit_layout", { clear = false })

-- При повторной загрузке ftplugin заменяем подписки только текущего буфера.
vim.api.nvim_clear_autocmds({ group = group, buffer = 0 })
vim.api.nvim_create_autocmd({ "BufLeave", "VimLeavePre" }, {
  group = group,
  buffer = 0,
  callback = require("config.switch_to_english").switch_to_english,
  desc = "Switch layout to English when leaving the commit editor",
})
