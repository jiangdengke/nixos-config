# ==================== ZSH Shell 主配置文件（Zim 框架）====================
# ZSH (Z Shell) 配置，使用 Zim 框架 + magicmace 主题
# Zim 特点：模块化、可定制、极速启动（比 Oh My Zsh 快 10 倍）
# 文件位置：~/.config/home-manager/home/zsh/default.nix

{ config, pkgs, ... }:

{
  # ==================== ZSH 基本配置 ====================
  programs.zsh = {
    # 启用 ZSH
    enable = true;

    # ==================== Zsh 环境设置 ====================
    # Zim 配置目录
    dotDir = ".config/zsh";

    # ==================== 自动启动 Wayland 会话 ====================
    # 登录到 tty1 时自动启动 Niri Wayland 会话
    profileExtra = ''
      if [[ -z $WAYLAND_DISPLAY && "$(tty)" == "/dev/tty1" ]]; then
        exec niri --session
      fi
    '';

    # ==================== 命令历史配置 ====================
    # ZSH 的命令历史功能
    history = {
      # 内存中保存的历史命令数量
      size = 10000;

      # 历史文件保存位置
      path = "${config.xdg.dataHome}/zsh/history";

      # 忽略重复的命令
      ignoreDups = true;

      # 历史文件满时优先删除重复项
      expireDuplicatesFirst = true;

      # 扩展历史格式（保存时间戳）
      extended = true;

      # 写入历史文件的命令数量
      save = 10000;
    };

    # ==================== Shell 别名配置 ====================
    shellAliases = {
      # ===== 文件操作别名 =====
      ls = "eza";
      l = "eza -l --icons --git";
      la = "eza -la --icons --git";
      lt = "eza -T --icons --git-ignore";
      cat = "bat";

      # ===== 系统操作别名 =====
      update = "sudo nixos-rebuild switch";
      hmupdate = "home-manager switch";

      # ===== Git 快捷别名 =====
      g = "git";
      ga = "git add";
      gc = "git commit";
      gs = "git status";
      gd = "git diff";
      gp = "git push";
      gl = "git pull";
      glog = "git log --oneline --decorate --graph";

      # ===== 快速导航别名 =====
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";

      # ===== 配置文件编辑别名 =====
      zshrc = "$EDITOR $HOME/.zshrc";
      nixconf = "$EDITOR $HOME/.config/nixpkgs/configuration.nix";
    };

    # ==================== Zim 配置加载 ====================
    # 加载 Zim 框架和自定义配置
    initExtra = builtins.readFile ./zshrc-zim.zsh;

    # ==================== 环境变量配置 ====================
    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      PAGER = "less -R";
      MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    };
  };

  # ==================== Zim 配置文件部署 ====================
  # 将 zimrc 配置文件复制到正确位置
  home.file = {
    ".zimrc" = {
      source = ./zimrc;
    };
  };

  # ==================== 安装必要的命令行工具 ====================
  home.packages = with pkgs; [
    # ===== 现代化命令行工具 =====
    eza           # ls 替代品
    bat           # cat 替代品
    fd            # find 替代品
    ripgrep       # grep 替代品
    zoxide        # cd 的智能替代
    fzf           # 模糊查找工具
    jq            # JSON 处理工具
  ];
}

# ==================== ZSH 使用提示 ====================
# magicmace 主题特点：
#   - 简洁单行提示符
#   - 显示：当前目录 + Git 状态
#   - 状态指示：错误码、后台任务、Python venv
#   - 颜色可定制
#
# Zim 框架管理命令：
#   zimfw install  - 安装新模块
#   zimfw update   - 更新所有模块
#   zimfw uninstall - 卸载模块
#   zimfw upgrade  - 升级 zimfw 本身
#   zimfw info     - 查看已安装模块
#
# 快捷键：
#   Ctrl+R - 模糊搜索历史命令
#   Ctrl+T - 模糊搜索文件
#   上/下箭头 - 搜索匹配当前输入的历史命令
#   右箭头 - 接受自动建议
#
# 常用命令：
#   l      - 列出文件（长格式）
#   la     - 列出所有文件
#   lt     - 树形显示目录
#   fcd    - 模糊查找并进入目录
#   fvim   - 模糊查找并编辑文件
