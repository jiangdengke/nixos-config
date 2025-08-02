{ config, pkgs, ... }:

{
  # Neovim 配置
  programs.neovim = {
    enable = true;
    
    # 创建别名，使得 vi 和 vim 命令都指向 nvim
    viAlias = true;
    vimAlias = true;
    
    # 启用 Python 和 Node.js 支持（用于某些插件）
    withPython3 = true;
    withNodeJs = true;
    
    # 默认编辑器
    defaultEditor = true;
    
    # 确保支持系统剪贴板
    extraPackages = with pkgs; [
      xclip         # X11 剪贴板支持
      wl-clipboard  # Wayland 剪贴板支持
      
      # LSP 和自动补全支持
      nodePackages.pyright  # Python LSP
      nodejs               # NodeJS
      rnix-lsp            # Nix LSP
    ];
    
    # 插件配置
    plugins = with pkgs.vimPlugins; [
      # 界面美化
      vim-airline        # 状态栏美化
      vim-airline-themes
      dracula-vim        # 主题
      
      # 文件导航和搜索
      telescope-nvim     # 模糊搜索
      nvim-web-devicons
      
      # 语法高亮和语言支持
      nvim-treesitter
      nvim-treesitter-parsers.python
      nvim-treesitter-parsers.nix
      nvim-treesitter-parsers.bash
      nvim-treesitter-parsers.vim
      
      # 代码补全和 LSP
      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      luasnip           # 代码片段引擎
      cmp_luasnip       # nvim-cmp 的 luasnip 源
      
      # Git 集成
      vim-fugitive
      vim-gitgutter
      
      # 实用工具
      vim-surround      # 括号引号修改
      vim-commentary    # 代码注释
      vim-repeat        # 增强 . 命令
      auto-pairs        # 自动配对括号
    ];
    
    # Neovim 配置
    extraConfig = ''
      " 基本设置
      set number                  " 显示行号
      set relativenumber          " 显示相对行号
      set cursorline              " 高亮当前行
      set expandtab               " 使用空格代替 tab
      set tabstop=4               " tab 宽度为 4 空格
      set shiftwidth=4            " 自动缩进宽度为 4 空格
      set softtabstop=4           " 编辑时 tab 的宽度
      set autoindent              " 自动缩进
      set smartindent             " 智能缩进
      set showmatch               " 显示匹配的括号
      set ignorecase              " 搜索忽略大小写
      set smartcase               " 如果搜索包含大写字母，不忽略大小写
      set incsearch               " 增量搜索
      set hlsearch                " 高亮搜索结果
      set hidden                  " 允许在有未保存的修改时切换缓冲区
      set termguicolors           " 启用 24 位真彩色
      
      " 剪贴板设置（重要！）
      set clipboard+=unnamedplus  " 使用系统剪贴板
      
      " 设置主题
      colorscheme dracula
      
      " 设置 leader 键为空格
      let mapleader = " "
      
      " 保存和退出的快捷键
      nnoremap <leader>w :w<CR>
      nnoremap <leader>q :q<CR>
      
      " 窗口导航
      nnoremap <C-h> <C-w>h
      nnoremap <C-j> <C-w>j
      nnoremap <C-k> <C-w>k
      nnoremap <C-l> <C-w>l
      
      " 复制粘贴相关快捷键
      vnoremap <leader>y "+y      " 复制到系统剪贴板
      nnoremap <leader>p "+p      " 从系统剪贴板粘贴
      nnoremap <leader>P "+P      " 从系统剪贴板粘贴（在光标前）
      
      " 防止误触键
      map <F1> <Esc>
      imap <F1> <Esc>
      
      " 可视模式下的缩进操作不退出可视模式
      vnoremap < <gv
      vnoremap > >gv
      
      " 移动选中的行
      vnoremap J :m '>+1<CR>gv=gv
      vnoremap K :m '<-2<CR>gv=gv
      
      " 插件配置
      " Telescope
      nnoremap <leader>ff <cmd>Telescope find_files<cr>
      nnoremap <leader>fg <cmd>Telescope live_grep<cr>
      nnoremap <leader>fb <cmd>Telescope buffers<cr>
      nnoremap <leader>fh <cmd>Telescope help_tags<cr>
    '';
    
    # Lua 配置（用于现代 Neovim 插件）
    extraLuaConfig = ''
      -- 配置 LSP
      local lspconfig = require('lspconfig')
      
      -- Python LSP
      lspconfig.pyright.setup {}
      
      -- Nix LSP
      lspconfig.rnix.setup {}
      
      -- Treesitter 配置
      require('nvim-treesitter.configs').setup {
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
      }
      
      -- 补全配置
      local cmp = require('cmp')
      local luasnip = require('luasnip')
      
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = {
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        }, {
          { name = 'buffer' },
          { name = 'path' },
        })
      })
    '';
  };
  
  # 确保安装剪贴板工具
  home.packages = with pkgs; [
    xclip
  ];
}
