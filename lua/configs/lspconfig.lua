local nvlsp = require "nvchad.configs.lspconfig"

dofile(vim.g.base46_cache .. "lsp")
require("nvchad.lsp").diagnostic_config()

-- nvlsp.on_init uses the deprecated client.supports_method(...) call form;
-- reimplemented here with client:supports_method(...) to avoid the warning
local function on_init(client, _)
  if client:supports_method "textDocument/semanticTokens" then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

-- replaces vim-illuminate (unmaintained vim.region() deprecation) with
-- Neovim's built-in LSP document highlight
local function on_attach(client, bufnr)
  nvlsp.on_attach(client, bufnr)

  if client:supports_method "textDocument/documentHighlight" then
    local group = vim.api.nvim_create_augroup("LspDocumentHighlight", { clear = false })
    vim.api.nvim_clear_autocmds { group = group, buffer = bufnr }

    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      group = group,
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      group = group,
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end
end

vim.lsp.config("*", {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = nvlsp.capabilities,
})

-- lua_ls set up via the new API directly instead of nvlsp.defaults(),
-- which calls the deprecated require("lspconfig").lua_ls.setup{...}
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          vim.fn.expand "$VIMRUNTIME/lua",
          vim.fn.expand "$VIMRUNTIME/lua/vim/lsp",
          vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types",
          vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
          "${3rd}/luv/library",
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
})
vim.lsp.enable "lua_ls"

vim.lsp.enable {
  "html",
  "ts_ls",
  "clangd",
  "phpactor",
  "gopls",
  "pyright",
  "yamlls",
  "dockerls",
  "tailwindcss",
  "intelephense",
  "psalm",
  "rust_analyzer",
  "vhdl_ls",
  "bacon_ls",
}

-- astro: locate typescript SDK relative to the git root of the workspace
vim.lsp.config("astro", {
  root_markers = { "astro.config.mjs", "package.json" },
  before_init = function(params, config)
    local root = (params.workspaceFolders or {})[1]
    root = root and vim.uri_to_fname(root.uri) or vim.fn.getcwd()
    local path = root
    while path ~= "/" do
      if vim.uv.fs_stat(path .. "/.git") then
        root = path
        break
      end
      path = vim.fn.fnamemodify(path, ":h")
    end
    config.init_options = vim.tbl_deep_extend("force", config.init_options or {}, {
      typescript = { tsdk = root .. "/node_modules/typescript/lib" },
    })
  end,
})
vim.lsp.enable "astro"

vim.lsp.config("tilt_ls", {
  filetypes = { "tiltfile" },
  root_markers = { "Tiltfile", ".git" },
})
vim.lsp.enable "tilt_ls"
