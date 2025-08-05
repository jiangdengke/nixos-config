return {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "neovim/nvim-lspconfig",
  },
  event = "BufReadPre",
  opts = {
    -- 自动安装配置的 LSP 服务器
    automatic_installation = true,
    -- 确保安装这些 LSP 服务器
    ensure_installed = {
      "lua_ls",
      "gopls",
      "pyright",
      "tsserver",
      "nil_ls", -- Nix 语言服务器
    },
  },
  config = function(_, opts)
    -- 设置延迟加载，确保 mason.nvim 已经初始化
    vim.defer_fn(function()
      require("mason-lspconfig").setup(opts)
      
      -- 设置 LSP 服务器
      require("mason-lspconfig").setup_handlers({
        -- 默认处理器
        function(server_name)
          require("lspconfig")[server_name].setup({})
        end,
        
        -- 特殊配置的服务器
        ["lua_ls"] = function()
          require("lspconfig").lua_ls.setup({
            settings = {
              Lua = {
                diagnostics = {
                  globals = { "vim" },
                },
              },
            },
          })
        end,
      })
    end, 100)
  end,
}
