-- ==================== Neovim 键位映射配置 ====================
-- 这个文件包含了所有自定义的快捷键设置
-- 键位映射让你可以用简短的按键执行复杂的操作
-- 文件位置：lua/core/keymaps.lua

-- ==================== Leader 键设置 ====================
-- 设置 Leader 键为空格键
-- Leader 键是一个特殊的前缀键，用于自定义快捷键
-- 例如：<leader>w 表示按空格键后按 w
-- 这样可以避免与 Vim 默认快捷键冲突
vim.g.mapleader = " "

-- 创建 vim.keymap 的本地引用，简化代码
local keymap = vim.keymap

-- ==================== 插入模式快捷键 ====================
-- 插入模式（Insert Mode）：正在输入文本的模式
-- 当前没有设置插入模式的快捷键

-- ==================== 视觉模式快捷键 ====================
-- 视觉模式（Visual Mode）：用于选择文本的模式

-- 向下移动选中的行（J 键）
-- :m '>+1<CR>：将选中的行移动到选区下方第一行之后
-- gv：重新选中之前的选区
-- =gv：自动缩进选中的行
-- 效果：选中文本后按 J，文本向下移动一行
keymap.set("v", "J", ":m '>+1<CR>gv=gv")

-- 向上移动选中的行（K 键）
-- :m '<-2<CR>：将选中的行移动到选区上方第一行之前
-- 效果：选中文本后按 K，文本向上移动一行
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- ==================== 正常模式快捷键 ====================
-- 正常模式（Normal Mode）：Vim 的默认模式，用于导航和执行命令

-- ===== 窗口管理 =====
-- 垂直分割窗口（<leader>sv = Space + s + v）
-- <C-w>v：Vim 原生的垂直分割命令
-- 效果：将当前窗口垂直分割成左右两个窗口
keymap.set("n", "<leader>sv", "<C-w>v")

-- 水平分割窗口（<leader>sh = Space + s + h）
-- <C-w>s：Vim 原生的水平分割命令
-- 效果：将当前窗口水平分割成上下两个窗口
keymap.set("n", "<leader>sh", "<C-w>s")

-- ===== 文件保存与退出 =====
-- 保存并退出（<leader>wq = Space + w + q）
-- :wq：写入文件并退出
keymap.set("n", "<leader>wq", ":wq<CR>")

-- 强制退出不保存（<leader>qq = Space + q + q）
-- :q!：强制退出，丢弃所有未保存的修改
keymap.set("n", "<leader>qq", ":q!<CR>")

-- 保存文件（<leader>w = Space + w）
-- :w：写入（保存）当前文件
keymap.set("n", "<leader>w", ":w<CR>")

-- ===== 快速移动 =====
-- 向下快速移动 5 行（J 键）
-- 5j：向下移动 5 行
-- 注意：这会覆盖 Vim 原生的 J（合并行）命令
keymap.set("n", "J", "5j")

-- 向上快速移动 5 行（K 键）
-- 5k：向上移动 5 行
-- 注意：这会覆盖 Vim 原生的 K（查看帮助）命令
keymap.set("n", "K", "5k")

-- ===== 搜索高亮控制 =====
-- 取消搜索高亮（<leader>nh = Space + n + h）
-- :nohl：no highlight，取消搜索匹配的高亮显示
-- 效果：清除搜索后黄色的高亮标记
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- ===== Markdown 预览 =====
-- 打开 Markdown 预览（<leader>m = Space + m）
-- :MarkdownPreview：启动 Markdown 实时预览
-- 需要安装 markdown-preview.nvim 插件
keymap.set("n", "<leader>m", ":MarkdownPreview<CR>")

-- ===== 缓冲区管理 =====
-- 关闭当前缓冲区（<leader>c = Space + c）
-- :bd：buffer delete，关闭当前缓冲区（文件）
-- 效果：关闭当前打开的文件，但不退出 Neovim
keymap.set("n", "<leader>c", ":bd<CR>")

-- 打开 Lazy 插件管理器（<leader>la = Space + l + a）
-- :Lazy：打开 lazy.nvim 的管理界面
-- 可以在这里更新、安装、删除插件
keymap.set("n", "<leader>la", ":Lazy<CR>")

-- ===== 缓冲区切换 =====
-- 切换到下一个缓冲区（Ctrl + L）
-- :bnext：buffer next，跳转到下一个缓冲区
-- 效果：在多个打开的文件之间向前切换
keymap.set("n", "<C-L>", ":bnext<CR>")

-- 切换到上一个缓冲区（Ctrl + H）
-- :bprevious：buffer previous，跳转到上一个缓冲区
-- 效果：在多个打开的文件之间向后切换
keymap.set("n", "<C-H>", ":bprevious<CR>")

-- ==================== 插件相关快捷键 ====================
-- 这部分包含需要插件支持的快捷键

-- ===== Neo-tree 文件浏览器 =====
-- 打开/关闭文件浏览器（<leader>e = Space + e）
-- :Neotree：打开 Neo-tree 文件浏览器插件
-- Neo-tree 是一个现代化的文件管理器，类似 VSCode 的侧边栏
-- 可以浏览、创建、删除、重命名文件和目录
keymap.set("n", "<leader>e", ":Neotree<CR>")

-- ==================== 快捷键总结 ====================
-- 窗口管理：
--   <Space>sv - 垂直分割
--   <Space>sh - 水平分割
--
-- 文件操作：
--   <Space>wq - 保存并退出
--   <Space>qq - 强制退出
--   <Space>w  - 保存文件
--   <Space>c  - 关闭缓冲区
--
-- 移动导航：
--   J/K - 快速向下/上移动5行
--   Ctrl+L/H - 切换缓冲区
--
-- 功能快捷键：
--   <Space>nh - 取消搜索高亮
--   <Space>m  - Markdown 预览
--   <Space>e  - 文件浏览器
--   <Space>la - 插件管理器
--
-- 视觉模式：
--   J/K - 移动选中的行
