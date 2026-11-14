-- Neovim >= 0.11；所有 cmd 均由 programs.neovim.extraPackages 提供。
-- 不通过 Mason 下载另一份语言服务器。
local servers = {
  lua_ls = {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
    settings = {
      Lua = {
        runtime = { version = "LuaJIT" },
        diagnostics = { globals = { "vim" } },
        workspace = { library = { vim.env.VIMRUNTIME }, checkThirdParty = false },
        telemetry = { enable = false },
      },
    },
  },
  gopls = {
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    root_markers = { "go.work", "go.mod", ".git" },
  },
  pyright = {
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
    root_markers = { "pyproject.toml", "setup.py", "requirements.txt", ".git" },
  },
  nil_ls = {
    cmd = { "nil" },
    filetypes = { "nix" },
    root_markers = { "flake.nix", "default.nix", ".git" },
  },
  ts_ls = {
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
  },
  phpactor = {
    cmd = { "phpactor", "language-server" },
    filetypes = { "php" },
    root_markers = { "composer.json", ".git" },
  },
  marksman = {
    cmd = { "marksman", "server" },
    filetypes = { "markdown", "markdown.mdx" },
    root_markers = { ".marksman.toml", ".git" },
  },
}

vim.lsp.config("*", {
  capabilities = require("blink.cmp").get_lsp_capabilities(),
})
for name, config in pairs(servers) do
  vim.lsp.config(name, config)
  vim.lsp.enable(name)
end
