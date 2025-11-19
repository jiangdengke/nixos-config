-- ==================== Neovim 编辑器选项配置 ====================
-- 这个文件包含了 Neovim 的所有基础设置
-- 包括：行号、缩进、搜索、外观、剪贴板等
-- 文件位置：lua/core/options.lua

-- 创建 vim.opt 的本地引用，简化代码
local opt = vim.opt

-- ==================== 行号显示配置 ====================
-- 显示相对行号（当前行显示绝对行号，其他行显示相对行号）
-- 相对行号方便使用 j/k 进行跳转，如 5j 跳转到下方第5行
opt.relativenumber = true

-- 显示绝对行号（在左侧边栏显示行号）
opt.number = true

-- ==================== 缩进设置 ====================
-- Tab 键的宽度（显示为4个空格）
opt.tabstop = 4

-- 自动缩进时使用的空格数（按 >> 或 << 缩进4个空格）
opt.shiftwidth = 4

-- 将 Tab 转换为空格（按 Tab 键时插入空格而不是制表符）
opt.expandtab = true

-- 自动缩进（新行自动继承上一行的缩进）
opt.autoindent = true

-- ==================== 文本换行设置 ====================
-- 启用自动换行（长行会自动换行显示）
-- true：自动换行，false：长行需要水平滚动
opt.wrap = true

-- ==================== 光标行高亮 ====================
-- 高亮当前光标所在行（方便查看当前编辑位置）
opt.cursorline = true

-- ==================== 鼠标支持 ====================
-- 在所有模式下启用鼠标支持（a = all modes）
-- 可以使用鼠标点击、选择、滚动等
opt.mouse:append("a")

-- ==================== 系统剪贴板集成 ====================
-- 使用系统剪贴板（unnamedplus）
-- 这样 yank/paste 操作会使用系统剪贴板
-- 可以在 Neovim 和其他应用之间复制粘贴
opt.clipboard:append("unnamedplus")

-- ==================== 窗口分割行为 ====================
-- 垂直分割时，新窗口在右侧打开
-- 使用 :vsplit 或 <C-w>v 时生效
opt.splitright = true

-- 水平分割时，新窗口在下方打开
-- 使用 :split 或 <C-w>s 时生效
opt.splitbelow = true

-- ==================== 搜索行为配置 ====================
-- 搜索时忽略大小写
-- 例如搜索 "hello" 会匹配 "Hello", "HELLO" 等
opt.ignorecase = true

-- 智能大小写搜索
-- 如果搜索词包含大写字母，则区分大小写
-- 如果全是小写，则忽略大小写
opt.smartcase = true

-- ==================== 外观设置 ====================
-- 启用真彩色支持（24-bit RGB 颜色）
-- 让配色方案显示更加丰富和准确
opt.termguicolors = true

-- 始终显示符号列（左侧边栏）
-- "yes"：始终显示，避免出现诊断信息时界面跳动
-- "no"：不显示，"auto"：自动显示
opt.signcolumn = "yes"

-- 命令模式显示补全菜单
-- 在命令行输入时显示可用的补全选项
vim.o.wildmenu = true

-- ==================== 文件自动保存配置 ====================
-- 100毫秒没有输入时自动保存交换文件
-- 交换文件用于崩溃恢复
vim.o.updatetime = 100

-- ==================== 文件位置记忆 ====================
-- 打开文件时自动跳转到上次编辑的位置
-- au BufReadPost：读取文件后触发
-- g'\"：跳转到上次退出时的光标位置
vim.cmd([[au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]])

-- ==================== 输入法自动切换 ====================
-- Fcitx5 输入法自动管理配置
-- 在 Normal 模式下自动切换为英文输入法
-- 这样在命令模式下不会受到中文输入法的干扰

-- InsertLeave：离开插入模式时（进入 Normal 模式）
-- BufCreate：创建新缓冲区时
-- BufEnter：进入缓冲区时
-- BufLeave：离开缓冲区时
-- fcitx5-remote -c：关闭 fcitx5 输入法（切换到英文）
vim.cmd([[
autocmd InsertLeave * :silent !fcitx5-remote -c
autocmd BufCreate *  :silent !fcitx5-remote -c
autocmd BufEnter *  :silent !fcitx5-remote -c
autocmd BufLeave *  :silent !fcitx5-remote -c
]])

-- ==================== 配色方案设置 ====================
-- 设置 Neovim 的配色方案
-- tokyonight-night：Tokyo Night 主题的夜间版本（已注释）
-- vim.cmd[[colorscheme tokyonight-night]]

-- onedark：One Dark 主题（当前使用）
-- One Dark 是 Atom 编辑器的经典配色方案
vim.cmd[[colorscheme onedark]]
