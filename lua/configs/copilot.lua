local options = {
  suggestion = { enabled = false },
  panel = { enabled = false },
  -- Possible configurable fields can be found on:
  -- https://github.com/zbirenbaum/copilot.lua#setup-and-configuration
  -- suggestion = {
  -- auto_trigger = true,
  -- },
  -- panel = {
  --   enabled = true,
  --   auto_refresh = true,
  --   keymap = {
  --     jump_prev = "[[",
  --     jump_next = "]]",
  --     accept = "<CR>",
  --     refresh = "gr",
  --     open = "<C-CR>",
  --   },
  --   layout = {
  --     position = "right", -- | top | left | right
  --     ratio = 0.4,
  --   },
  -- },
  -- suggestion = {
  --   enabled = true,
  --   auto_accept = true,
  --   auto_trigger = true,
  --   debounce = 50,
  --   keymap = {
  --     accept = "<Tab>",
  --     accept_word = false,
  --     accept_line = false,
  --     next = "<M-]>",
  --     prev = "<M-[>",
  --     dismiss = "<C-]>",
  --   },
  -- },
  -- filetypes = {
  --   yaml = true,
  --   markdown = true,
  --   help = false,
  --   gitcommit = true,
  --   gitrebase = false,
  --   hgcommit = false,
  --   svn = false,
  --   cvs = false,
  --   ["."] = false,
  -- },
  -- copilot_node_command = "node", -- Node.js version must be > 16.x
  -- server_opts_overrides = {},
}

return options
