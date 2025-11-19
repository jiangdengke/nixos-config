{ config, pkgs, lib, ... }:

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

      # Lua 格式化器（重复声明，可能需要清理）
      stylua

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

      # Go 额外工具集（goimports、godoc 等）
      gotools

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
      nodePackages.typescript

      # TypeScript Language Server（TS/JS 代码补全）
      nodePackages.typescript-language-server

      # Node.js 运行时（运行 JavaScript 代码）
      nodejs
    ];
  };

  # ==================== XDG 基础目录规范 ====================
  # 启用 XDG 目录支持（~/.config、~/.local/share 等）
  # 这是 Linux 下的标准配置目录结构
  xdg.enable = true;

  # ==================== 环境变量配置 ====================
  # 设置全局环境变量
  home.sessionVariables = {
    # 默认编辑器设置为 nvim
    EDITOR = "nvim";

    # 可视化编辑器也设置为 nvim
    VISUAL = "nvim";

    # ===== Mason 插件配置 =====
    # Mason 是 Neovim 的 LSP/DAP/Linter 管理器
    # 强制设置 Mason 的安装目录到 XDG 数据目录
    # 这样可以保持配置的整洁性
    MASON_INSTALL_DIR = lib.mkForce "${config.xdg.dataHome}/nvim/mason";
  };

  # ==================== Neovim 配置文件管理 ====================
  # 使用激活脚本在每次 Home Manager 切换时复制配置
  # 这种方式允许 Neovim 插件在运行时修改配置文件
  home.activation = {
    # 定义复制 Neovim 配置的激活脚本
    # entryAfter ["writeBoundary"] 确保在文件写入边界之后执行
    copyNeovimConfig = lib.hm.dag.entryAfter ["writeBoundary"] ''
      # ===== 创建必要的 Neovim 目录 =====
      # XDG_DATA_HOME/nvim：插件数据、状态文件
      $DRY_RUN_CMD mkdir -p $VERBOSE_ARG ${config.xdg.dataHome}/nvim

      # XDG_STATE_HOME/nvim：编辑器状态（undo 历史等）
      $DRY_RUN_CMD mkdir -p $VERBOSE_ARG ${config.xdg.stateHome}/nvim

      # XDG_CACHE_HOME/nvim：临时缓存文件
      $DRY_RUN_CMD mkdir -p $VERBOSE_ARG ${config.xdg.cacheHome}/nvim

      # ===== 备份旧配置 =====
      # 如果已存在 nvim 配置目录，先备份
      # 备份文件名包含时间戳，避免覆盖
      if [ -d "${config.xdg.configHome}/nvim" ]; then
        $DRY_RUN_CMD mv $VERBOSE_ARG ${config.xdg.configHome}/nvim ${config.xdg.configHome}/nvim.bak.$(date +%Y%m%d%H%M%S)
      fi

      # ===== 复制新配置到配置目录 =====
      # 创建配置根目录
      $DRY_RUN_CMD mkdir -p $VERBOSE_ARG ${config.xdg.configHome}

      # 递归复制 nvim 配置目录
      # ./nvim 指向当前目录下的 nvim 文件夹
      $DRY_RUN_CMD cp -r $VERBOSE_ARG ${./nvim} ${config.xdg.configHome}/nvim

      # ===== 设置正确的文件权限 =====
      # 确保用户对配置文件有写权限
      # 这样插件管理器可以安装和更新插件
      $DRY_RUN_CMD chmod -R u+w $VERBOSE_ARG ${config.xdg.configHome}/nvim
      $DRY_RUN_CMD chmod -R u+w $VERBOSE_ARG ${config.xdg.dataHome}/nvim
      $DRY_RUN_CMD chmod -R u+w $VERBOSE_ARG ${config.xdg.cacheHome}/nvim
    '';
  };

  # ==================== 确保配置目录存在 ====================
  # 创建一个空的 .keep 文件确保目录被创建
  # 即使配置还没复制，目录也会存在
  home.file = {
    ".config/nvim/.keep".text = "";
  };

  # ==================== 重要提示 ====================
  # Yanky 插件配置说明：
  # Yanky 是一个 Neovim 的剪贴板管理插件
  # 在 NixOS 环境下，需要使用 shada 或 memory 存储模式
  # 相关配置应该在 ./nvim/lua/config/plugins/yanky.lua 中设置
  # 这样可以避免 SQLite 数据库相关的权限问题
}
