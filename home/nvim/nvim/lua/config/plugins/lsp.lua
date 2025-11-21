return {
  -- 配置 nvim-lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- 可选：使用 Mason 来安装 LSP 服务器
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local lspconfig = require("lspconfig")

      -- 针对 marksman（Markdown LSP）进行配置
      lspconfig.marksman.setup({
        -- 如果需要自定义设置，放到这里
        -- settings = { ... }
      })

      -- PHP Language Server (phpactor)
      -- 通过 Nix 安装，不需要 Mason
      lspconfig.phpactor.setup({
        -- phpactor 配置
        -- settings = { ... }
      })
    end,
  },
}
