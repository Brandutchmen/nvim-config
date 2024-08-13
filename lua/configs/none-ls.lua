local options = {
  -- A list of sources to install if they're not already installed.
  -- This setting has no relation with the `automatic_installation` setting.
  ensure_installed = {
    "html",
    "typescript-language-server",
    "tailwindcss-language-server",
    "clangd",
    "phpactor",
    "astro",
    "gopls",
    "pyright",
    "yamlls",
    "dockerls",
    "docker-langserver",
    "tailwindcss",
    "gopls",
    "gofmt",
    "goimports",
    "gci",
  },
  -- Enable or disable null-ls methods to get set up
  -- This setting is useful if some functionality is handled by other plugins such as `conform` and `nvim-lint`
  methods = {
    diagnostics = true,
    formatting = false, -- handled by Conform
    code_actions = true,
    completion = true,
    hover = true,
  },
  -- Run `require("null-ls").setup`.
  -- Will automatically install masons tools based on selected sources in `null-ls`.
  -- Can also be an exclusion list.
  -- Example: `automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }`
  automatic_installation = true,
  -- See [#handlers-usage](#handlers-usage) section
  handlers = nil,
}
return options
