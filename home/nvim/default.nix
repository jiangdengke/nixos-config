{ pkgs, ... }:

{
  # ==================== Neovim 编辑器配置 ====================
  # 使用 Home Manager 的 Neovim 模块来管理 Neovim 配置
  programs.neovim = {
    # 启用 Neovim
    enable = true;

    # 将 Neovim 设置为系统默认编辑器
    # 设置后 EDITOR 和 VISUAL 环境变量会指向 nvim
    defaultEditor = true;

    # 创建 vi 命令别名指向 nvim
    # 这样输入 vi 时实际会启动 nvim
    viAlias = true;

    # 创建 vim 命令别名指向 nvim
    # 这样输入 vim 时实际会启动 nvim
    vimAlias = true;

    # 使用未经包装的 Neovim 包
    # unwrapped 版本允许我们自己管理插件和配置
    package = pkgs.neovim-unwrapped;

    # 显式保留旧默认值，避免 Home Manager 26.05 之后默认值变化带来的 warning。
    withRuby = true;
    withPython3 = true;

    # ==================== 额外工具包 ====================
    # 这些包会被添加到 Neovim 的运行时环境中
    # 插件可以直接调用这些工具，无需单独安装
    extraPackages = with pkgs; [
      # ===== 代码格式化工具 =====
      # Nix 代码格式化器（RFC 风格）
      nixfmt-rfc-style

      # Lua 代码格式化器
      stylua

      # ===== 系统依赖 =====
      # SQLite 数据库（用于某些插件存储数据）
      sqlite

      # C 编译器（编译某些 Neovim 插件需要）
      gcc

      # Make 构建工具（编译插件依赖）
      gnumake

      # ===== Neovim 核心依赖工具 =====
      # Lua Language Server（Lua 语言支持）
      lua-language-server

      # Markdown LSP 与 shell 格式化器由 Nix 提供。
      marksman
      shfmt

      # 快速文本搜索工具（Telescope 等插件依赖）
      ripgrep

      # 快速文件查找工具（Telescope 等插件依赖）
      fd

      # 网络下载工具
      curl
      wget

      # 解压工具（Mason 等插件管理器需要）
      unzip

      # 版本控制工具（Git 集成插件需要）
      git

      # ===== Go 语言开发工具链 =====
      # Go Language Server（Go 代码补全和诊断）
      gopls

      # Go 代码检查工具（多种 linter 集合）
      golangci-lint

      # Go 调试器
      delve

      # Go 编译器和运行时
      go

      # ===== Python 语言开发工具链 =====
      # Python Language Server（Python 代码补全和诊断）
      pyright

      # Python 3 解释器
      python3

      # Python 代码格式化器（官方推荐）
      python3Packages.black

      # Python 代码风格检查工具
      python3Packages.flake8

      # Python import 语句排序工具
      python3Packages.isort

      # Python 代码质量检查工具
      python3Packages.pylint

      # ===== Nix 语言开发工具链 =====
      # Nix 代码格式化器
      nixpkgs-fmt

      # Nix Language Server（Nix 代码补全和诊断）
      nil

      # ===== TypeScript/JavaScript 开发工具链 =====
      # TypeScript 编译器
      typescript

      # TypeScript Language Server（TS/JS 代码补全）
      typescript-language-server

      # Node.js 运行时（运行 JavaScript 代码）
      nodejs

      # ===== PHP 开发工具链 =====
      # PHP Language Server（PHP 代码补全和诊断）
      phpactor
    ];
  };

  # ==================== XDG 基础目录规范 ====================
  # 启用 XDG 目录支持（~/.config、~/.local/share 等）
  # 这是 Linux 下的标准配置目录结构
  xdg.enable = true;

  # 逐文件链接配置；遇到未受管理的不同内容时由 Home Manager 报错，
  # 不删除用户目录。首次迁移请按 README 保留原配置。
  xdg.configFile."nvim" = {
    source = ./nvim;
    recursive = true;
  };
}
