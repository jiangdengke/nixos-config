-- 改变nvim的yank和put功能
return{
  "gbprod/yanky.nvim",
  dependencies = {
    -- 移除 sqlite 依赖
    -- { "kkharji/sqlite.lua" }
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    require("yanky").setup({
      ring = { 
        storage = "shada" -- 使用 shada 存储，不需要 SQLite，但有持久性
        -- 或者使用 storage = "memory" 如果您不需要持久性
      },
      preserve_cursor_position = {
        enabled = true,
      }
    })
    
    -- 加载 telescope 扩展
    require("telescope").load_extension("yank_history")
    
    -- 配置键映射
    vim.keymap.set("n", "<leader>p", function() require("telescope").extensions.yank_history.yank_history({ }) end, { desc = "打开复制历史" })
    vim.keymap.set({"n","x"}, "y", "<Plug>(YankyYank)", { desc = "复制文本" })
    vim.keymap.set({"n","x"}, "p", "<Plug>(YankyPutAfter)", { desc = "将复制的文本放到光标之后" })
    vim.keymap.set({"n","x"}, "P", "<Plug>(YankyPutBefore)", { desc = "将复制的文本放到光标之前" })
    vim.keymap.set({"n","x"}, "gp", "<Plug>(YankyGPutAfter)", { desc = "将复制的文本放到选择内容之后" })
    vim.keymap.set({"n","x"}, "gP", "<Plug>(YankyGPutBefore)", { desc = "将复制的文本放到选择内容之前" })
    vim.keymap.set("n", "<c-p>", "<Plug>(YankyPreviousEntry)", { desc = "通过复制历史选择上一个条目" })
    vim.keymap.set("n", "<c-n>", "<Plug>(YankyNextEntry)", { desc = "通过复制历史选择下一个条目" })
    vim.keymap.set("n", "]p", "<Plug>(YankyPutIndentAfterLinewise)", { desc = "在光标后粘贴并缩进（按行）" })
    vim.keymap.set("n", "[p", "<Plug>(YankyPutIndentBeforeLinewise)", { desc = "在光标前粘贴并缩进（按行）" })
    vim.keymap.set("n", "]P", "<Plug>(YankyPutIndentAfterLinewise)", { desc = "在光标后粘贴并缩进（按行）" })
    vim.keymap.set("n", "[P", "<Plug>(YankyPutIndentBeforeLinewise)", { desc = "在光标前粘贴并缩进（按行）" })
    vim.keymap.set("n", ">p", "<Plug>(YankyPutIndentAfterShiftRight)", { desc = "粘贴并向右缩进" })
    vim.keymap.set("n", "<p", "<Plug>(YankyPutIndentAfterShiftLeft)", { desc = "粘贴并向左缩进" })
    vim.keymap.set("n", ">P", "<Plug>(YankyPutIndentBeforeShiftRight)", { desc = "在之前粘贴并向右缩进" })
    vim.keymap.set("n", "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)", { desc = "在之前粘贴并向左缩进" })
    vim.keymap.set("n", "=p", "<Plug>(YankyPutAfterFilter)", { desc = "应用过滤器后粘贴" })
    vim.keymap.set("n", "=P", "<Plug>(YankyPutBeforeFilter)", { desc = "应用过滤器之前粘贴" })
  end,
}
