{ config, pkgs, lib, ... }:

{
  # 使用 Home Manager 的 Neovim 模块
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    package = pkgs.neovim-unwrapped;
    # 不使用 package 属性，让 Home Manager 使用系统默认的 Neovim
    
    # 添加额外的包
    extraPackages = with pkgs; [
    nixfmt-rfc-style
    stylua  # Lua 格式化器
      sqlite
      # 基础开发工具
      gcc
      gnumake
      
      # Neovim 依赖的工具
      lua-language-server
      stylua
      ripgrep
      fd
      curl
      wget
      unzip
      git
      
      # Language servers 和语言支持
      gopls
      golangci-lint
      delve
      go
      gotools
      
      pyright
      python3
      python3Packages.black
      python3Packages.flake8
      python3Packages.isort
      python3Packages.pylint
      
      nixpkgs-fmt
      nil # Nix language server
      
      nodePackages.typescript
      nodePackages.typescript-language-server
      nodejs
    ];
  };

  # 设置 XDG 目录
  xdg.enable = true;

  # 设置环境变量
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    # Mason 特定的环境变量
    MASON_INSTALL_DIR = lib.mkForce "${config.xdg.dataHome}/nvim/mason";
  };
  
  # 使用激活脚本处理 Neovim 配置
  home.activation = {
    copyNeovimConfig = lib.hm.dag.entryAfter ["writeBoundary"] ''
      # 创建必要的目录
      $DRY_RUN_CMD mkdir -p $VERBOSE_ARG ${config.xdg.dataHome}/nvim
      $DRY_RUN_CMD mkdir -p $VERBOSE_ARG ${config.xdg.stateHome}/nvim
      $DRY_RUN_CMD mkdir -p $VERBOSE_ARG ${config.xdg.cacheHome}/nvim
      
      # 如果存在就备份旧配置
      if [ -d "${config.xdg.configHome}/nvim" ]; then
        $DRY_RUN_CMD mv $VERBOSE_ARG ${config.xdg.configHome}/nvim ${config.xdg.configHome}/nvim.bak.$(date +%Y%m%d%H%M%S)
      fi
      
      # 复制新配置
      $DRY_RUN_CMD mkdir -p $VERBOSE_ARG ${config.xdg.configHome}
      $DRY_RUN_CMD cp -r $VERBOSE_ARG ${./nvim} ${config.xdg.configHome}/nvim
      
      # 设置正确的权限
      $DRY_RUN_CMD chmod -R u+w $VERBOSE_ARG ${config.xdg.configHome}/nvim
      $DRY_RUN_CMD chmod -R u+w $VERBOSE_ARG ${config.xdg.dataHome}/nvim
      $DRY_RUN_CMD chmod -R u+w $VERBOSE_ARG ${config.xdg.cacheHome}/nvim
    '';
  };

  # 确保目录存在
  home.file = {
    ".config/nvim/.keep".text = "";
  };

  # 注意：您需要确保 yanky.lua 使用 shada 或 memory 存储
  # 这个文件应该位于 ./nvim/lua/config/plugins/yanky.lua
  # 请确保在复制到配置目录之前修改此文件
}
