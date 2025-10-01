-- 引导加载 lazy.nvim 插件管理器
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- 检查 lazy.nvim 是否已安装
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	-- 如果没有安装，则克隆 lazy.nvim 仓库
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	-- 检查克隆是否成功
	if vim.v.shell_error ~= 0 then
		-- 如果克隆失败，显示错误消息
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
-- 将 lazy.nvim 添加到运行时路径
vim.opt.rtp:prepend(lazypath)

-- 在加载 lazy.nvim 之前设置 leader 和 localleader 键
-- 这也是设置其他 vim 选项的好地方
vim.g.mapleader = " "          -- 设置全局 leader 键为空格
vim.g.maplocalleader = "\\"    -- 设置局部 leader 键为反斜杠

-- 设置 lazy.nvim
require("lazy").setup({
	-- 用户界面相关插件
	require("config.plugins.lualine"),      -- 状态栏
	require("config.plugins.bufferline"),   -- 标签栏
	require("config.plugins.noice"),        -- 通知和命令行增强
	
	-- 工具类插件
	require("config.plugins.imgclip"),      -- 剪贴板图片支持
	require("config.plugins.markdown-preview"), -- Markdown 预览
	require("config.plugins.gitsigns"),     -- Git 集成
	require("config.plugins.yazi-nvim"),    -- 文件管理器
	require("config.plugins.telescope"),    -- 模糊查找器
	require("config.plugins.which-key"),    -- 快捷键提示
	require("config.plugins.yanky"),        -- 剪贴板历史管理
	require("config.plugins.flash"),        -- 快速跳转
	
	-- 编辑增强插件
	require("config.plugins.mini-pairs"),   -- 自动括号配对
	require("config.plugins.mini-surround"), -- 环绕编辑
	require("config.plugins.vim-easy-align"), -- 对齐文本
	require("config.plugins.vim-table-mode"), -- 表格模式
	require("config.plugins.ts-comments"),  -- 注释支持
	
	-- 代码分析和格式化
	require("config.plugins.nvim-treesitter"), -- 语法高亮和分析
	require("config.plugins.conform"),      -- 代码格式化（不依赖 LSP）
	require("config.plugins.nvim-lint"),    -- 代码检查（不依赖 LSP）
	
	-- 补全系统
	require("config.plugins.autocomplete"), -- 自动补全
	
	-- 包管理器
	require("config.plugins.mason"),        -- 工具安装管理
	
	-- LSP 配置 (已注释)
	-- require("config.plugins.lsp"),        -- LSP 客户端配置
	-- require("config.plugins.mason-lspconfig"), -- Mason 与 LSP 集成
	
	-- 开发工具 (已注释)
	-- require("config.plugins.lazydev"),    -- 开发工具
})
