-- ==================== Lazy.nvim 插件管理器配置 ====================
-- lazy.nvim 是一个现代化的 Neovim 插件管理器
-- 特点：延迟加载、快速启动、自动安装、锁定版本
-- 项目地址：https://github.com/folke/lazy.nvim
-- 文件位置：lua/config/lazy.lua

-- ==================== 自动安装 lazy.nvim ====================
-- 计算 lazy.nvim 的安装路径
-- stdpath("data") 返回 Neovim 数据目录，通常是 ~/.local/share/nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- 检查 lazy.nvim 是否已经安装
-- fs_stat 检查文件或目录是否存在
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    -- lazy.nvim 的 GitHub 仓库地址
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"

    -- 如果没有安装，使用 git 克隆 lazy.nvim 仓库
    -- --filter=blob:none：减小克隆体积，不下载历史记录中的大文件
    -- --branch=stable：克隆稳定版分支
    local out = vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        lazyrepo,
        lazypath
    })

    -- 检查 git 克隆是否成功
    -- shell_error 为 0 表示命令执行成功
    if vim.v.shell_error ~= 0 then
        -- 如果克隆失败，显示错误消息并退出
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        -- 等待用户按键
        vim.fn.getchar()
        -- 退出 Neovim
        os.exit(1)
    end
end

-- 将 lazy.nvim 添加到 Neovim 的运行时路径
-- prepend：添加到路径最前面，确保优先加载
vim.opt.rtp:prepend(lazypath)

-- ==================== Leader 键配置 ====================
-- 在加载插件之前设置 leader 键非常重要
-- 因为很多插件会使用 leader 键来定义快捷键

-- 设置全局 leader 键为空格键
-- leader 键用于自定义快捷键，例如 <leader>w 表示空格+w
vim.g.mapleader = " "

-- 设置局部 leader 键为反斜杠
-- localleader 用于特定文件类型的快捷键
vim.g.maplocalleader = "\\"

-- ==================== 插件加载配置 ====================
-- 调用 lazy.nvim 的 setup 函数加载所有插件
-- 每个 require 语句都会加载对应的插件配置文件
require("lazy").setup({
    -- ===== 用户界面相关插件 =====
    -- 这些插件改善 Neovim 的视觉外观

    -- lualine：底部状态栏
    -- 显示文件信息、Git 状态、LSP 状态等
    require("config.plugins.lualine"),

    -- bufferline：顶部缓冲区标签栏
    -- 以标签页形式显示打开的文件
    require("config.plugins.bufferline"),

    -- noice：通知和命令行美化
    -- 提供更美观的消息、命令行和搜索界面
    require("config.plugins.noice"),

    -- ===== 工具类插件 =====
    -- 这些插件提供各种实用功能

    -- imgclip：剪贴板图片支持
    -- 可以直接粘贴图片到 Markdown 等文件中
    require("config.plugins.imgclip"),

    -- markdown-preview：Markdown 实时预览
    -- 在浏览器中实时预览 Markdown 文件
    require("config.plugins.markdown-preview"),

    -- gitsigns：Git 集成
    -- 显示 Git 变更、提供 Git 操作快捷键
    require("config.plugins.gitsigns"),

    -- yazi-nvim：文件管理器集成
    -- 集成 yazi 终端文件管理器
    require("config.plugins.yazi-nvim"),

    -- telescope：模糊查找器
    -- 快速查找文件、文本、符号等
    require("config.plugins.telescope"),

    -- which-key：快捷键提示
    -- 按 leader 键后显示可用的快捷键
    require("config.plugins.which-key"),

    -- yanky：剪贴板历史管理
    -- 保存和管理复制历史，支持循环粘贴
    require("config.plugins.yanky"),

    -- flash：快速跳转
    -- 快速跳转到屏幕上的任意位置
    require("config.plugins.flash"),

    -- ===== 编辑增强插件 =====
    -- 这些插件提升编辑体验

    -- mini-pairs：自动括号配对
    -- 自动补全括号、引号等成对符号
    require("config.plugins.mini-pairs"),

    -- mini-surround：环绕编辑
    -- 快速添加、修改、删除环绕符号（括号、引号等）
    require("config.plugins.mini-surround"),

    -- vim-easy-align：文本对齐
    -- 按特定字符对齐多行文本
    require("config.plugins.vim-easy-align"),

    -- vim-table-mode：表格模式
    -- 快速创建和编辑 Markdown/文本表格
    require("config.plugins.vim-table-mode"),

    -- ts-comments：智能注释
    -- 根据语言自动使用正确的注释符号
    require("config.plugins.ts-comments"),

    -- ===== 代码分析和格式化 =====
    -- 这些插件提供语法高亮、格式化、检查功能

    -- nvim-treesitter：语法高亮和代码分析
    -- 基于 Tree-sitter 的精确语法高亮和代码理解
    require("config.plugins.nvim-treesitter"),

    -- conform：代码格式化（独立于 LSP）
    -- 支持各种代码格式化工具（prettier、black 等）
    require("config.plugins.conform"),

    -- nvim-lint：代码检查（独立于 LSP）
    -- 支持各种 linter（eslint、pylint 等）
    require("config.plugins.nvim-lint"),

    -- ===== 自动补全系统 =====
    -- 代码补全和智能提示

    -- autocomplete：自动补全配置
    -- 集成 nvim-cmp 及各种补全源
    require("config.plugins.autocomplete"),

    -- ===== 工具管理器 =====
    -- 管理外部工具的安装

    -- mason：LSP/DAP/Linter 安装管理器
    -- 自动下载和管理各种开发工具
    require("config.plugins.mason"),

    -- ===== LSP 配置（已注释） =====
    -- Language Server Protocol 相关配置
    -- 注释掉是因为可能使用其他 LSP 配置方式

    -- lsp：LSP 客户端配置
    -- 配置各种语言服务器
    -- require("config.plugins.lsp"),

    -- mason-lspconfig：Mason 与 LSP 集成
    -- 自动安装 LSP 服务器
    -- require("config.plugins.mason-lspconfig"),

    -- ===== 开发工具（已注释） =====
    -- 其他开发辅助工具

    -- lazydev：Lua 开发工具
    -- 为 Neovim 插件开发提供补全
    -- require("config.plugins.lazydev"),
})

-- ==================== 插件管理器使用说明 ====================
-- 常用命令：
--   :Lazy - 打开插件管理界面
--   :Lazy update - 更新所有插件
--   :Lazy sync - 同步插件（安装缺失的，删除多余的）
--   :Lazy clean - 清理未使用的插件
--   :Lazy check - 检查更新
--
-- 插件配置文件位置：
--   lua/config/plugins/*.lua
--
-- 每个插件配置文件返回一个 lazy.nvim 的插件规范表
-- 包含：插件名、依赖、配置函数、快捷键等
