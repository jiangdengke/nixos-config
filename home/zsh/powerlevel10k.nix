# ==================== Powerlevel10k 主题配置 ====================
# Powerlevel10k 是一个快速、灵活、功能强大的 ZSH 主题
# 特点：即时提示、Git 集成、自定义元素、瞬时提示模式
# 项目地址：https://github.com/romkatv/powerlevel10k
# 文件位置：~/.config/home-manager/home/zsh/powerlevel10k.nix

{ pkgs, ... }:

{
  # ==================== ZSH 插件配置 ====================
  programs.zsh = {
    plugins = [
      # ===== Powerlevel10k 主题插件 =====
      # 加载 Powerlevel10k 主题
      {
        # 插件名称
        name = "powerlevel10k";

        # 从 nixpkgs 获取 Powerlevel10k
        # 这是预编译的版本，启动速度更快
        src = pkgs.zsh-powerlevel10k;

        # 主题文件路径
        # 指向 Powerlevel10k 的主题配置文件
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }

      # ===== Powerlevel10k 个人配置 =====
      # 加载自定义的 p10k.zsh 配置文件
      {
        # 配置名称
        name = "powerlevel10k-config";

        # 将本地的 p10k.zsh 文件写入 Nix store
        # 这样可以确保配置文件在正确的位置
        src = pkgs.writeTextFile {
          # 文件名称
          name = "p10k-config";

          # 文件内容（从 ./p10k.zsh 读取）
          # p10k.zsh 包含所有主题的详细配置
          text = builtins.readFile ./p10k.zsh;

          # 目标文件路径
          # 文件会被写入到 Nix store 中的这个位置
          destination = "/p10k.zsh";
        };

        # 配置文件路径
        # ZSH 会加载这个文件来应用 Powerlevel10k 配置
        file = "p10k.zsh";
      }
    ];
  };

  # ==================== 字体配置 ====================
  # Powerlevel10k 需要 Nerd Font 来正确显示图标
  # MesloLGL Nerd Font 是 Powerlevel10k 推荐的字体
  fonts.fontconfig = {
    # 启用字体配置
    enable = true;

    # ===== 默认字体设置 =====
    # 为不同用途设置默认字体
    defaultFonts = {
      # 等宽字体（用于终端、代码编辑器）
      # MesloLGL Nerd Font: 包含所有 Nerd Font 图标
      # Noto Sans CJK SC: 中文支持（简体中文）
      monospace = [
        "MesloLGL Nerd Font"
        "MesloLGL Nerd Font Mono"
        "Noto Sans CJK SC"
      ];

      # 衬线字体（用于阅读长文本）
      # 适用于文档、网页等
      serif = [
        "MesloLGL Nerd Font"
        "Noto Serif CJK SC"
      ];

      # 无衬线字体（用于 UI 界面）
      # 适用于系统界面、应用程序等
      sansSerif = [
        "MesloLGL Nerd Font"
        "Noto Sans CJK SC"
      ];
    };
  };
}

# ==================== Powerlevel10k 使用说明 ====================
# 配置文件：
#   p10k.zsh - 包含所有主题配置（颜色、图标、布局等）
#   可以编辑此文件来自定义主题外观
#
# 主要特性：
#   - 即时提示：ZSH 启动时立即显示提示符
#   - 瞬时提示：历史命令自动简化显示
#   - Git 集成：显示分支、状态、提交信息
#   - 多语言支持：Python、Node.js、Go、Rust 等
#   - 自定义元素：可以添加任何想要的信息
#
# 重新配置：
#   如果想重新运行配置向导，执行：
#   p10k configure
#
# 手动编辑：
#   直接编辑 p10k.zsh 文件，然后重新加载：
#   source ~/.p10k.zsh
#
# 字体要求：
#   必须使用支持 Nerd Font 的字体
#   推荐：MesloLGS NF（Powerlevel10k 官方推荐）
#   当前配置：MesloLGL Nerd Font
