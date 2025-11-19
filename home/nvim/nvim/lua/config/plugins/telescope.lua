-- ==================== Telescope 模糊查找器插件 ====================
-- Telescope 是一个高度可扩展的模糊查找器
-- 用途：查找文件、搜索文本、浏览符号、Git 操作等
-- 项目地址：https://github.com/nvim-telescope/telescope.nvim
-- 文件位置：lua/config/plugins/telescope.lua

return {
    -- ==================== 插件基本信息 ====================
    -- 插件的 GitHub 仓库名称
    "nvim-telescope/telescope.nvim",

    -- 使用指定的版本标签（稳定版本）
    -- 版本 0.1.8 是一个稳定的发布版本
    tag = "0.1.8",

    -- 也可以使用分支（已注释）
    -- branch = '0.1.x' 会跟踪 0.1.x 分支的最新提交
    -- branch = '0.1.x',

    -- ==================== 插件依赖 ====================
    -- Telescope 依赖 plenary.nvim 库
    -- plenary 提供了一些 Lua 工具函数和异步操作支持
    dependencies = { "nvim-lua/plenary.nvim" },

    -- ==================== 插件配置函数 ====================
    -- config 函数在插件加载后自动执行
    -- 用于设置插件的选项和快捷键
    config = function()
        -- 导入 telescope.builtin 模块
        -- builtin 包含了 Telescope 的所有内置功能
        local builtin = require('telescope.builtin')

        -- ===== 查找文件快捷键 =====
        -- <leader>ff = Space + f + f
        -- 功能：在当前目录下模糊查找文件名
        -- 效果：打开文件选择器，可以输入文件名进行模糊匹配
        -- 使用场景：快速打开项目中的文件
        vim.keymap.set('n', '<leader>ff', builtin.find_files, {
            desc = 'Telescope find files'
        })

        -- ===== 文本搜索快捷键 =====
        -- <leader>fg = Space + f + g
        -- 功能：在所有文件中实时搜索文本内容（live grep）
        -- 效果：打开搜索界面，输入关键词在项目中搜索
        -- 使用场景：查找包含特定文本的所有文件
        -- 注意：需要安装 ripgrep (rg) 命令行工具
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, {
            desc = 'Telescope live grep'
        })

        -- ===== 缓冲区列表快捷键 =====
        -- <leader>fb = Space + f + b
        -- 功能：显示所有打开的缓冲区（文件）列表
        -- 效果：打开缓冲区选择器，可以快速切换到其他打开的文件
        -- 使用场景：在多个打开的文件之间快速切换
        vim.keymap.set('n', '<leader>fb', builtin.buffers, {
            desc = 'Telescope buffers'
        })

        -- ===== 帮助文档搜索快捷键 =====
        -- <leader>fh = Space + f + h
        -- 功能：搜索 Neovim 的帮助文档标签
        -- 效果：打开帮助文档搜索器，可以查找插件和命令的帮助
        -- 使用场景：查找 Vim/Neovim 功能的文档说明
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, {
            desc = 'Telescope help tags'
        })
    end,
}

-- ==================== Telescope 使用说明 ====================
-- 快捷键总结：
--   <Space>ff - 查找文件（find files）
--   <Space>fg - 搜索文本（grep）
--   <Space>fb - 浏览缓冲区（buffers）
--   <Space>fh - 搜索帮助（help）
--
-- Telescope 界面操作：
--   输入文本：进行模糊匹配搜索
--   Ctrl+n/Ctrl+p：上下移动
--   j/k：上下移动（Vim 风格）
--   Enter：打开选中的项目
--   Ctrl+c/Esc：关闭 Telescope
--   Ctrl+u/Ctrl+d：向上/下滚动预览窗口
--
-- 其他可用的 builtin 功能：
--   builtin.grep_string - 搜索光标下的单词
--   builtin.oldfiles - 最近打开的文件
--   builtin.git_files - Git 仓库中的文件
--   builtin.git_commits - Git 提交历史
--   builtin.lsp_references - LSP 引用查找
--   builtin.lsp_definitions - LSP 定义跳转
