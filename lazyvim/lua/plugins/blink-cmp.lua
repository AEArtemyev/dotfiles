-- Плагин для completion.
return {
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "default",

        -- принять completion
        ["<C-y>"] = { "select_and_accept" },

        -- обычный Enter
        ["<CR>"] = { "fallback" },

        -- обычный Tab / Shift-Tab
        ["<Tab>"] = { "fallback" },
        ["<S-Tab>"] = { "fallback" },
      },
    },
  },
}
