# ==================== ZSH Shell 主配置文件（Zim 框架）====================
# ZSH (Z Shell) 配置，使用 Zim 框架 + magicmace 主题
# Zim 特点：模块化、可定制、极速启动（比 Oh My Zsh 快 10 倍）
# 文件位置：~/.config/home-manager/home/zsh/default.nix

{ config, pkgs, lib, ... }:

let
  pins = builtins.fromJSON (builtins.readFile ./zim-sources.json);
  modules = lib.mapAttrs (name: pin: pkgs.fetchFromGitHub {
    owner = "zimfw";
    repo = name;
    inherit (pin) rev hash;
  }) pins;
  zimrc = pkgs.replaceVars ./zimrc (modules // {
    magicmace = ./magicmace;
    syntaxHighlighting = "${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting";
    autosuggestions = "${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions";
    historySubstringSearch = "${pkgs.zsh-history-substring-search}/share/zsh-history-substring-search";
  });
in
{
  # ==================== ZSH 基本配置 ====================
  programs.zsh = {
    # 启用 ZSH
    enable = true;

    # ==================== Zsh 环境设置 ====================
    # Zim 配置目录（使用绝对路径）
    dotDir = "${config.xdg.configHome}/zsh";

    # 禁用 home-manager 自动调用 compinit
    # 让 Zim 的 completion 模块来处理
    enableCompletion = false;

    # 新机器安装阶段先不要在 tty1 自动进入 Niri，避免图形会话异常时直接黑屏。
    # 登录后可手动执行 `niri-session` 排查或启动桌面。
    profileExtra = "";

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
      # 在配置仓库根目录执行；Home Manager 随 NixOS 一起更新。
      update = "sudo nixos-rebuild switch --flake .";
      hmupdate = "sudo nixos-rebuild switch --flake .";

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
      nixconf = "$EDITOR ./flake.nix";
    };

    # ==================== Zim 配置加载 ====================
    # 加载 Zim 框架和自定义配置
    initContent = builtins.replaceStrings
      [ "@zimfw@" "@zimrc@" "@zimHome@" ]
      [ "${pkgs.zimfw}/zimfw.zsh" "${zimrc}" "${config.xdg.cacheHome}/zim/${builtins.baseNameOf zimrc}" ]
      (builtins.readFile ./zshrc-zim.zsh);

    # ==================== 环境变量配置 ====================
    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      PAGER = "less -R";
      MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    };
  };

  # ==================== Zim 配置部署 ====================
  # Zim 只读取 Nix store 中的模块；初始化缓存随配置路径隔离。
  home.file.".config/zsh/.zimrc".source = zimrc;

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
# Zim 维护：修改 zim-sources.json 的版本与哈希后重新构建。
# 模块位于只读 Nix store；不要使用 zimfw update/upgrade 修改它们。
# zimfw info 可查看已加载模块。
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
