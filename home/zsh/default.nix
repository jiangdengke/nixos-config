# ==================== ZSH Shell 主配置文件 ====================
# ZSH (Z Shell) 是一个功能强大的 shell
# 特点：智能补全、主题支持、插件系统、命令历史增强
# 文件位置：~/.config/home-manager/home/zsh/default.nix

{ config, pkgs, ... }:

let
  # ==================== 动态替换配置路径 ====================
  # 在构建时将 @p10kTheme@ 替换为实际的 Powerlevel10k 主题路径
  # 这样可以确保主题文件路径始终正确
  zshrcExtra = builtins.replaceStrings
    [ "@p10kTheme@" ]
    [ "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme" ]
    (builtins.readFile ./zshrc.zsh);
in
{
  # ==================== 导入 Powerlevel10k 配置 ====================
  # Powerlevel10k 是一个快速、灵活的 ZSH 主题
  # 提供美观的提示符、Git 集成、命令状态等功能
  imports = [ ./powerlevel10k.nix ];

  # ==================== ZSH 基本配置 ====================
  programs.zsh = {
    # 启用 ZSH
    enable = true;

    # ==================== 自动启动 Wayland 会话 ====================
    # 登录到 tty1 时自动启动 Niri Wayland 会话
    # 这样开机后直接进入图形界面，无需手动启动
    profileExtra = ''
      if [[ -z $WAYLAND_DISPLAY && "$(tty)" == "/dev/tty1" ]]; then
        exec niri --session
      fi
    '';

    # ==================== 命令历史配置 ====================
    # ZSH 的命令历史功能可以记住你执行过的所有命令
    history = {
      # 内存中保存的历史命令数量
      size = 10000;

      # 历史文件保存位置
      # 使用 XDG 标准目录，保持配置文件整洁
      path = "${config.xdg.dataHome}/zsh/history";

      # 忽略重复的命令
      # 连续执行相同命令只记录一次
      ignoreDups = true;

      # 历史文件满时优先删除重复项
      expireDuplicatesFirst = true;

      # 扩展历史格式
      # 保存命令的时间戳和执行时间
      extended = true;

      # 写入历史文件的命令数量
      save = 10000;
    };

    # ==================== Shell 别名配置 ====================
    # 别名可以让你用简短的命令替代复杂的命令
    shellAliases = {
      # ===== 文件操作别名 =====
      # 使用现代化工具替代传统命令

      # 使用 eza 替代 ls（更美观、功能更强）
      ls = "eza";

      # 长格式显示，带图标和 Git 信息
      # 显示文件权限、所有者、大小、修改时间等
      l = "eza -l --icons --git";

      # 显示所有文件（包括隐藏文件）
      la = "eza -la --icons --git";

      # 树形显示目录结构
      # 自动忽略 .gitignore 中的文件
      lt = "eza -T --icons --git-ignore";

      # 使用 bat 替代 cat（带语法高亮）
      cat = "bat";

      # ===== 系统操作别名 =====
      # NixOS 系统管理命令

      # 更新 NixOS 系统配置
      # sudo 权限用于修改系统级配置
      update = "sudo nixos-rebuild switch";

      # 更新 Home Manager 用户配置
      # 不需要 sudo，只影响当前用户
      hmupdate = "home-manager switch";

      # ===== Git 快捷别名 =====
      # 简化常用的 Git 命令

      g = "git";                    # Git 基础命令
      ga = "git add";               # 添加文件到暂存区
      gc = "git commit";            # 提交更改
      gs = "git status";            # 查看仓库状态
      gd = "git diff";              # 查看差异
      gp = "git push";              # 推送到远程仓库
      gl = "git pull";              # 从远程仓库拉取
      glog = "git log --oneline --decorate --graph";  # 图形化查看提交历史

      # ===== 快速导航别名 =====
      # 快速返回上级目录

      ".." = "cd ..";               # 返回上一级
      "..." = "cd ../..";           # 返回上两级
      "...." = "cd ../../..";       # 返回上三级

      # ===== 配置文件编辑别名 =====
      # 快速打开常用配置文件

      # 编辑 ZSH 配置（使用环境变量中定义的编辑器）
      zshrc = "$EDITOR $HOME/.zshrc";

      # 编辑 NixOS 配置
      nixconf = "$EDITOR $HOME/.config/nixpkgs/configuration.nix";
    };

    # ==================== ZSH 插件配置 ====================
    # 插件为 ZSH 添加额外功能
    plugins = [
      # ===== 语法高亮插件 =====
      # 输入命令时实时高亮语法
      # 有效命令显示绿色，无效命令显示红色
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "0.7.1";
          sha256 = "03r6hpb5fy4yaakqm3lbf4xcvd408r44jgpv4lnzl9asp4sb9qc0";
        };
      }

      # ===== 自动建议插件 =====
      # 根据历史命令自动提示
      # 输入时显示灰色建议，按右箭头接受
      {
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "v0.7.0";
          sha256 = "1g3pij5qn2j7v7jjac2a63lxd97mcsgw6xq6k5p7835q9fjiid98";
        };
      }

      # ===== 历史子串搜索插件 =====
      # 使用上下箭头搜索历史命令
      # 输入命令前缀后，按上箭头查找匹配的历史命令
      {
        name = "zsh-history-substring-search";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-history-substring-search";
          rev = "v1.0.2";
          sha256 = "0y8va5kc2ram38hbk2cibkk64ffrabfv1sh4xm7pjspsba9n5p1y";
        };
      }
    ];

    # ==================== 额外初始化配置 ====================
    # 加载 zshrc.zsh 中的自定义配置
    # 包括：选项设置、函数定义、环境变量等
    initContent = zshrcExtra;

    # ==================== Oh My ZSH 配置 ====================
    # Oh My ZSH 是一个流行的 ZSH 框架
    # 提供大量插件和主题
    oh-my-zsh = {
      # 启用 Oh My ZSH
      enable = true;

      # ===== Oh My ZSH 插件 =====
      # 每个插件提供特定功能
      plugins = [
        "git"                 # Git 命令补全和别名
        "sudo"                # 按两次 ESC 在命令前添加 sudo
        "docker"              # Docker 命令补全
        "extract"             # 智能解压命令 (extract file.tar.gz)
        "command-not-found"   # 命令未找到时提示安装方法
        "z"                   # 快速跳转到常用目录
      ];

      # ===== 主题设置 =====
      # 设置为空，因为使用 Powerlevel10k 替代
      # Powerlevel10k 比 Oh My ZSH 自带主题更强大
      theme = "";
    };

    # ==================== 环境变量配置 ====================
    # 设置 shell 会话的环境变量
    sessionVariables = {
      # 默认编辑器
      # 用于 git commit、crontab -e 等需要编辑器的场景
      EDITOR = "nvim";

      # 图形编辑器
      # 某些 GUI 程序使用此变量
      VISUAL = "nvim";

      # 分页器
      # 用于显示长输出（如 man 手册、git log 等）
      # -R 参数支持 ANSI 颜色代码
      PAGER = "less -R";

      # Man 手册分页器
      # 使用 bat 显示 man 手册，带语法高亮
      MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    };
  };

  # ==================== 安装必要的命令行工具 ====================
  # 这些工具增强 shell 使用体验
  home.packages = with pkgs; [
    # ===== 现代化命令行工具 =====

    # eza - 现代化的 ls 替代品
    # 特点：彩色输出、图标、Git 集成、树形显示
    eza

    # bat - cat 的替代品
    # 特点：语法高亮、Git 集成、行号、分页
    bat

    # fd - find 的替代品
    # 特点：更快、更简单的语法、默认忽略 .git
    fd

    # ripgrep - grep 的替代品
    # 特点：速度极快、默认递归搜索、智能忽略文件
    ripgrep

    # zoxide - cd 的智能替代
    # 特点：记住常用目录、快速跳转
    zoxide

    # fzf - 模糊查找工具
    # 特点：交互式查找、支持预览、可集成到各种工具
    fzf

    # jq - JSON 处理工具
    # 特点：解析、过滤、转换 JSON 数据
    jq
  ];
}

# ==================== ZSH 使用提示 ====================
# 快捷键：
#   Ctrl+R - 模糊搜索历史命令（需要 fzf）
#   Ctrl+T - 模糊搜索文件（需要 fzf）
#   Alt+C  - 模糊搜索目录并跳转（需要 fzf）
#   上/下箭头 - 搜索匹配当前输入的历史命令
#   右箭头 - 接受自动建议
#   ESC ESC - 在当前命令前添加 sudo
#
# 常用命令：
#   l      - 列出文件（长格式）
#   la     - 列出所有文件（包括隐藏文件）
#   lt     - 树形显示目录
#   bat    - 查看文件内容（带语法高亮）
#   fzf    - 交互式模糊查找
#   z dir  - 快速跳转到目录
#
# 自定义函数：
#   mkcd dir  - 创建目录并进入
#   extract file - 智能解压文件
#   fcd      - 模糊查找并进入目录
#   fvim     - 模糊查找并编辑文件
