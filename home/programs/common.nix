{
  lib,
  pkgs,
  catppuccin-bat,  # 引入 Catppuccin 主题作为外部依赖
  ...
}: {
  # 用户级软件包安装
  home.packages = with pkgs; [
    # 归档工具
    zip       # 创建 ZIP 压缩文件
    unzip     # 解压 ZIP 压缩文件
    p7zip     # 支持 7z 格式的压缩工具

    # 实用工具
    ripgrep   # 比 grep 更快的搜索工具
    yq-go     # YAML 处理工具，类似于 jq，但用于 YAML 文件
    htop      # 交互式系统监控工具

    # 其他工具
    libnotify      # 发送桌面通知的库
    wineWowPackages.wayland  # Wine 的 Wayland 支持版本，用于运行 Windows 应用程序
    xdg-utils      # freedesktop.org 实用工具，如 xdg-open
    graphviz       # 图形可视化工具，用于创建图表


    # 云原生工具
    docker-compose # Docker 容器编排工具

    # Node.js 开发环境
    nodejs         # Node.js JavaScript 运行环境
#    nodePackages.npm  # Node.js 包管理器
#    nodePackages.pnpm # 性能更好的 Node.js 包管理器
    yarn           # 另一个 Node.js 包管理器

    # 数据库相关工具
    dbeaver-bin    # 通用数据库管理工具
    mycli          # MySQL 命令行客户端，带自动补全和语法高亮
    pgcli          # PostgreSQL 命令行客户端，带自动补全和语法高亮
  ];

  programs = {
    # tmux 终端复用器配置
    tmux = {
      enable = true;       # 启用 tmux
      clock24 = true;      # 使用 24 小时制时钟
      keyMode = "vi";      # 使用 vi 按键模式
      extraConfig = "mouse on";  # 启用鼠标支持
    };

    # bat 是 cat 命令的增强版本，带有语法高亮
    bat = {
      enable = true;
      config = {
        pager = "less -FR";         # 使用 less 作为分页器，保持颜色和允许控制字符
        theme = "catppuccin-mocha"; # 使用 Catppuccin Mocha 主题
      };
      themes = {
        # 配置 Catppuccin Mocha 主题
        # https://raw.githubusercontent.com/catppuccin/bat/main/Catppuccin-mocha.tmTheme
        catppuccin-mocha = {
          src = catppuccin-bat;         # 使用外部引入的 catppuccin-bat 源
          file = "Catppuccin-mocha.tmTheme"; # 指定主题文件
        };
      };
    };

    btop.enable = true;    # 启用 btop，是 htop 和 nmon 的现代替代品
    eza.enable = true;     # 启用 eza，是 ls 命令的现代替代品，带有更多功能
    jq.enable = true;      # 启用 jq，轻量级灵活的 JSON 处理工具
    ssh.enable = true;     # 启用 SSH 客户端配置管理
    aria2.enable = true;   # 启用 aria2，轻量级多协议下载工具

    # skim 是一个模糊查找器，类似于 fzf
    skim = {
      enable = true;
      enableZshIntegration = true;  # 与 Zsh 集成
      defaultCommand = "rg --files --hidden";  # 默认命令，使用 ripgrep 查找文件，包括隐藏文件
      changeDirWidgetOptions = [
        # 为目录切换小部件设置预览选项，显示目录树
        "--preview 'exa --icons --git --color always -T -L 3 {} | head -200'" # 使用 exa 显示最多 3 层目录树，限制为 200 行
        "--exact"  # 使用精确匹配模式
      ];
    };
  };

  services = {
    syncthing.enable = true;  # 启用 Syncthing 文件同步服务

    # 自动挂载 USB 设备
    udiskie.enable = true;    # 启用 udiskie 服务，自动挂载和管理可移动存储设备
  };
}
