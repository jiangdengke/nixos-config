-- 格式化工具
return {
	"stevearc/conform.nvim",
	-- 我们将使用系统安装的工具
	lazy = true,
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = "",
			desc = "格式化文件",
		},
	},
	opts = {
		-- 配置格式化器
		formatters_by_ft = {
			lua = { "stylua" },
			toml = { "taplo" },
			css = { "prettier" },
			html = { "prettier" },
			json = { "prettier" },
			yaml = { "prettier" },
			markdown = { "prettier" },
			-- 使用正确的 Nix 格式化器
			nix = { "nixfmt-rfc-style" },
		},

		-- 保存时自动格式化
		format_on_save = {
			timeout_ms = 2000, -- 增加超时时间
			lsp_fallback = true,
			async = false,
		},

		-- 明确指定格式化器命令路径
		formatters = {
			-- 使用系统安装的二进制文件
			stylua = {
				command = "stylua",
			},
			["nixfmt-rfc-style"] = {
				command = "nixfmt", -- 命令名称是 nixfmt，即使包名是 nixfmt-rfc-style
			},
			prettier = {
				command = "prettier",
				prepend_args = { "--config-precedence", "prefer-file" },
			},
			taplo = {
				command = "taplo",
			},
		},

		-- 默认格式化配置
		default_format_opts = {
			timeout_ms = 2000,
			quiet = false,
			lsp_format = "fallback",
		},

		-- 日志等级
		log_level = vim.log.levels.ERROR,

		-- 通知设置
		notify_on_error = true,
		notify_no_formatters = false,
	},
	init = function()
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
}
