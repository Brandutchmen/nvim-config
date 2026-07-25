vim.g.lspconfig_suppress_deprecation_warning = true
vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = " "

-- silence the (harmless) "watch.watch: ENOENT" notice LSP clients log on
-- macOS when a registered file-watch base dir (e.g. node_modules) doesn't exist
do
  local notify_once = vim.notify_once
  vim.notify_once = function(msg, ...)
    if type(msg) == "string" and msg:match "^watch%.watch: " then
      return
    end
    return notify_once(msg, ...)
  end
end

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
    config = function()
      require "options"
    end,
  },

  { import = "plugins" },
}, lazy_config)

require("mason-null-ls").setup(require "configs.none-ls")

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)

-- highlight yanked text for 200ms using the "Visual" highlight group
vim.cmd [[
augroup highlight_yank
autocmd!
au TextYankPost * silent! lua vim.hl.on_yank({higroup="Visual", timeout=250})
augroup END
]]

vim.api.nvim_create_user_command("DiffFormat", function()
  local lines = vim.fn.system("git diff --unified=0"):gmatch "[^\n\r]+"
  local ranges = {}
  for line in lines do
    if line:find "^@@" then
      local line_nums = line:match "%+.- "
      if line_nums:find "," then
        local _, _, first, second = line_nums:find "(%d+),(%d+)"
        table.insert(ranges, {
          start = { tonumber(first), 0 },
          ["end"] = { tonumber(first) + tonumber(second), 0 },
        })
      else
        local first = tonumber(line_nums:match "%d+")
        table.insert(ranges, {
          start = { first, 0 },
          ["end"] = { first + 1, 0 },
        })
      end
    end
  end
  local format = require("conform").format
  for _, range in pairs(ranges) do
    format {
      range = range,
    }
  end
end, { desc = "Format changed lines" })

vim.opt.spell = true
vim.opt.spelllang = "en_us"

vim.g.indent_blankline_enabled = false

vim.api.nvim_set_keymap(
  "n",
  "<leader>tt",
  ":lua require('neotest').run.run()<CR>",
  { noremap = true, silent = true, desc = "Run nearest test" }
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>tf",
  ":lua require('neotest').run.run(vim.fn.expand('%'))<CR>",
  { noremap = true, silent = true, desc = "Test current file" }
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>tx",
  ":lua require('neotest').run.stop()<CR>",
  { noremap = true, silent = true, desc = "Stop current test" }
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>tA",
  ":lua require('neotest').run.attach()<CR>",
  { noremap = true, silent = true, desc = "Attach to test" }
)

--Run full test suite
vim.api.nvim_set_keymap(
  "n",
  "<leader>ta",
  ":lua require('neotest').run.run(vim.fn.getcwd())<CR>",
  { noremap = true, silent = true, desc = "Run all tests in suite" }
)

-- Run tests in directory

vim.api.nvim_set_keymap(
  "n",
  "<leader>tD",
  ":lua require('neotest').run.run(vim.fn.expand('%:p:h'))<CR>",
  { noremap = true, silent = true, desc = "Run all tests in directory" }
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>to",
  ":lua require('neotest').output.open()<CR>",
  { noremap = true, silent = true, desc = "Open test output" }
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>tO",
  ":lua require('neotest').output.open({ enter = true })<CR>",
  { noremap = true, silent = true, desc = "Open test output and enter insert mode" }
)

-- open summary
vim.api.nvim_set_keymap(
  "n",
  "<leader>ts",
  ":lua require('neotest').summary.toggle()<CR>",
  { noremap = true, silent = true, desc = "Toggle test summary" }
)

-- jump to failed test
vim.api.nvim_set_keymap(
  "n",
  "<leader>tn",
  ":lua require('neotest').jump.next({ status = 'failed' } )<CR>",
  { silent = true, desc = "Jump to next failed test" }
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>tp",
  ":lua require('neotest').jump.prev({ status = 'failed' } )<CR>",
  { silent = true, desc = "Jump to previous failed test" }
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>tl",
  ":lua require('neotest').output.toggle()<CR>",
  { silent = true, desc = "Toggle test output panel" }
)
-- watch
vim.api.nvim_set_keymap(
  "n",
  "<leader>tw",
  ":lua require('neotest').watch.toggle()<CR>",
  { silent = true, desc = "Toggle test watch panel" }
)

vim.fn.sign_define("DapBreakpoint", { text = "⬢", texthl = "Yellow", linehl = "", numhl = "Yellow" })
vim.fn.sign_define("DapStopped", { text = "▶", texthl = "Green", linehl = "ColorColumn", numhl = "Green" })

vim.api.nvim_set_keymap(
  "n",
  "<leader>i",
  "<cmd>lua vim.diagnostic.open_float()<CR>",
  { noremap = false, silent = true, desc = "Open diagnostic float" }
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>I",
  [[<cmd>lua (function() vim.diagnostic.open_float(); vim.diagnostic.open_float() end)()<CR>]],
  { noremap = false, silent = true, desc = "Open diagnostic float" }
)

-- set relative line numbers
vim.o.relativenumber = true
