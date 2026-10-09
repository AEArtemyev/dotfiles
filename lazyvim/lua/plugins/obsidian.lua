return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- use latest release, remove to use latest commit
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    legacy_commands = false, -- this will be removed in 4.0.0
    ui = {
      -- рендерить будет плагин render-markdown
      enable = false,
    },
    workspaces = {
      {
        name = "work",
        path = "~/YandexDisk/work/Obsidian Work",
      },
    },
  },
}
