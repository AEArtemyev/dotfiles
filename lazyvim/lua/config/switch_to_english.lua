local M = {}

function M.switch_to_english()
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

return M
