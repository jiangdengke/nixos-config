{ config, pkgs, ... }:

{
  # 注意修改这里的用户名与用户目录
  home.username = "jdk";
  home.homeDirectory = "/home/jdk";
  programs.home-manager.enable = true;


  # 设置字体
  fonts.fontconfig = {
    enable = true;
  };


  # 设置鼠标指针大小以及字体 DPI（适用于 4K 显示器）
  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 140;
  };

  # 通过 home.packages 安装一些常用的软件
  # 这些软件将仅在当前用户下可用，不会影响系统级别的配置
  # 建议将所有 GUI 软件，以及与 OS 关系不大的 CLI 软件，都通过 home.packages 安装
  home.packages = with pkgs;[
    # 如下是我常用的一些命令行工具，你可以根据自己的需要进行增删
    neofetch

    # archives
    zip
    xz
    unzip
    p7zip
    xorg.xfontsel
    xorg.xset

    # utils
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    yq-go # yaml processor https://github.com/mikefarah/yq
    eza # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder

    # networking tools
    mtr # A network diagnostic tool
    iperf3
    dnsutils  # `dig` + `nslookup`
    ldns # replacement of `dig`, it provide the command `drill`
    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing
    ipcalc  # it is a calculator for the IPv4/v6 addresses

    # misc
    cowsay
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg

    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor

    # productivity
    hugo # static site generator
    glow # markdown previewer in terminal

    btop  # replacement of htop/nmon
    iotop # io monitoring
    iftop # network monitoring

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # system tools
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb
  ];


  # 启用 starship，这是一个漂亮的 shell 提示符
  programs.starship = {
    enable = true;
    # 自定义配置
    settings = {
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
    };
  };

  programs.zsh = {
  enable = true;
  autosuggestion.enable = true;
  enableCompletion = true;
  
  # 基本配置
 initContent = ''
    export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
    
    # 历史记录设置
    HISTSIZE=10000
    SAVEHIST=10000
    setopt HIST_IGNORE_DUPS
    setopt HIST_IGNORE_SPACE
    setopt EXTENDED_HISTORY
    
    # 其他自定义设置
    setopt AUTO_CD
    setopt CORRECT
  '';
  
  # 别名设置
  shellAliases = {
    k = "kubectl";
    urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
    urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
    # zsh 特有的别名
    ll = "ls -la";
    ".." = "cd ..";
    "..." = "cd ../..";
  };
  
  # 可选：配置 oh-my-zsh
  oh-my-zsh = {
    enable = true;
    plugins = [
      "git"
      "docker"
      "kubectl"
      "sudo"
      "history"
      "z"
    ];
    theme = "robbyrussell"; # 或者其他你喜欢的主题
  };
  
  # 可选：配置 zsh 插件
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
  ];
};

  home.stateVersion = "25.05";
}
