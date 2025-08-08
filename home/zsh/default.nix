{ config, pkgs, ... }:

{
  # 导入 powerlevel10k 配置，替代 starship
  imports = [ ./powerlevel10k.nix ];

  # ZSH 配置
  programs.zsh = {
    enable = true;

    # 登录到 tty1 且尚未在 Wayland 会话时，启动 Hyprland
     profileExtra = ''
      if [[ -z $WAYLAND_DISPLAY && "$(tty)" == "/dev/tty1" ]]; then
        exec Hyprland
      fi
    '';
    # 历史设置
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
      ignoreDups = true;
      expireDuplicatesFirst = true;
      extended = true;
      save = 10000;
    };

    # ZSH 初始化脚本
    initContent = ''
      # 自定义配置
      setopt AUTO_CD              # 自动切换目录
      setopt EXTENDED_HISTORY     # 记录命令时间戳
      setopt HIST_EXPIRE_DUPS_FIRST # 首先删除重复历史
      setopt HIST_FIND_NO_DUPS    # 查找历史时忽略重复
      setopt HIST_IGNORE_DUPS     # 不记录重复命令
      setopt HIST_IGNORE_SPACE    # 不记录以空格开头的命令
      setopt SHARE_HISTORY        # 会话间共享历史

      # 自动建议配置
      ZSH_AUTOSUGGEST_STRATEGY=(history completion)
      ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#8a8a8a"

      # 加载 powerlevel10k
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

      # 添加自定义函数
      function mkcd() {
        mkdir -p "$1" && cd "$1"
      }
            # 确保 home-manager 在 PATH 中
      export PATH="$HOME/.nix-profile/bin:$PATH"
    '';

    # 常用别名
    shellAliases = {
      # 文件操作
      ls = "eza"; # 使用 eza 替代 ls
      l = "eza -l --icons --git"; # 长格式，带图标和 Git 信息
      la = "eza -la --icons --git"; # 长格式，显示隐藏文件
      lt = "eza -T --icons --git-ignore"; # 树形显示
      cat = "bat"; # 使用 bat 替代 cat

      # 系统操作
      update = "sudo nixos-rebuild switch"; # 更新 NixOS
      hmupdate = "home-manager switch"; # 更新 Home Manager 配置

      # Git 别名
      g = "git";
      ga = "git add";
      gc = "git commit";
      gs = "git status";
      gd = "git diff";
      gp = "git push";
      gl = "git pull";
      glog = "git log --oneline --decorate --graph";

      # 导航
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";

      # 快速打开和编辑配置文件
      zshrc = "$EDITOR $HOME/.config/nixpkgs/home/zsh/default.nix";
      nixconf = "$EDITOR $HOME/.config/nixpkgs/configuration.nix";
    };

    # 插件配置
    plugins = [
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "0.7.1";
          sha256 = "03r6hpb5fy4yaakqm3lbf4xcvd408r44jgpv4lnzl9asp4sb9qc0";
        };
      }
      {
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "v0.7.0";
          sha256 = "1g3pij5qn2j7v7jjac2a63lxd97mcsgw6xq6k5p7835q9fjiid98";
        };
      }
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

    # Oh My ZSH 配置
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "sudo"
        "docker"
        "extract"
        "command-not-found"
        "z"
      ];
      # 不再需要 robbyrussell 主题
      theme = "";
    };

    # 环境变量
    sessionVariables = {
      EDITOR = "vim"; # 或者 nvim，如果您使用 Neovim
      VISUAL = "code"; # 或您喜欢的图形编辑器
      PAGER = "less -R";
      MANPAGER = "sh -c 'col -bx | bat -l man -p'"; # 使用 bat 显示 man 页面
    };
  };

  # 安装必要的包
  home.packages = with pkgs; [
    eza # 现代化的 ls 替代品
    bat # cat 的替代品，带有语法高亮
    fd # find 的替代品
    ripgrep # grep 的替代品
    zoxide # z 命令的智能版本
    fzf # 模糊查找工具
    jq # JSON 处理工具
  ];
}
