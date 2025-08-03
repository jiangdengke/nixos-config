{ config, lib, pkgs, ... }:

{
  # 启用 Fastfetch
  programs.fastfetch = {
    enable = true;
    package = pkgs.fastfetch;
    
    # 主配置内容，使用随机 logo
    settings = {
      "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
      
      logo = {
        # 使用脚本随机选择 logo
        source = "\"$(~/.local/bin/fastfetch-random-logo.sh)\"";
        height = 18;
      };
      
      display = {
        separator = " : ";
      };
      
      modules = [
        {
          type = "command";
          key = "  ";
          keyColor = "blue";
          text = "splash=$(hyprctl splash);echo $splash";
        }
        {
          type = "custom";
          format = "┌──────────────────────────────────────────┐";
        }
        {
          type = "chassis";
          key = "  󰇺 Chassis";
          format = "{1} {2} {3}";
        }
        {
          type = "os";
          key = "  󰣇 OS";
          format = "{2}";
          keyColor = "red";
        }
        {
          type = "kernel";
          key = "   Kernel";
          format = "{2}";
          keyColor = "red";
        }
        {
          type = "packages";
          key = "  󰏗 Packages";
          keyColor = "green";
        }
        {
          type = "display";
          key = "  󰍹 Display";
          format = "{1}x{2} @ {3}Hz [{7}]";
          keyColor = "green";
        }
        {
          type = "terminal";
          key = "   Terminal";
          keyColor = "yellow";
        }
        {
          type = "wm";
          key = "  󱗃 WM";
          format = "{2}";
          keyColor = "yellow";
        }
        {
          type = "custom";
          format = "└──────────────────────────────────────────┘";
        }
        "break"
        {
          type = "title";
          key = "  ";
          format = "{6} {7} {8}";
        }
        {
          type = "custom";
          format = "┌──────────────────────────────────────────┐";
        }
        {
          type = "cpu";
          format = "{1} @ {7}";
          key = "   CPU";
          keyColor = "blue";
        }
        {
          type = "gpu";
          format = "{1} {2}";
          key = "  󰊴 GPU";
          keyColor = "blue";
        }
        {
          type = "gpu";
          format = "{3}";
          key = "   GPU Driver";
          keyColor = "magenta";
        }
        {
          type = "memory";
          key = "   Memory ";
          keyColor = "magenta";
        }
        {
          type = "disk";
          key = "  󱦟 OS Age ";
          folders = "/";
          keyColor = "red";
          format = "{days} days";
        }
        {
          type = "uptime";
          key = "  󱫐 Uptime ";
          keyColor = "red";
        }
        {
          type = "custom";
          format = "└──────────────────────────────────────────┘";
        }
        {
          type = "colors";
          paddingLeft = 2;
          symbol = "circle";
        }
        "break"
      ];
    };
  };
  
  # 创建随机 logo 选择器脚本，使用当前目录下的 logo 文件夹中的 .icon 文件
  home.file.".local/bin/fastfetch-random-logo.sh" = {
    executable = true;
    text = ''
      #!/bin/sh
      
      # 确定当前脚本位置并推导 logo 目录位置
      SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
      CONFIG_DIR="$(dirname "$SCRIPT_DIR")/.config/fastfetch"
      MODULE_DIR="$(dirname "$CONFIG_DIR")"
      LOGO_DIR="$MODULE_DIR/nixos-config/home/fastfetch/logo"
      
      # 检查标准位置的 logo 目录
      if [ ! -d "$LOGO_DIR" ]; then
        # 尝试另一种推导路径
        LOGO_DIR="$(dirname "$(dirname "$(dirname "$SCRIPT_DIR")")")/nixos-config/home/fastfetch/logo"
      fi
      
      # 如果仍然找不到，尝试硬编码路径
      if [ ! -d "$LOGO_DIR" ]; then
        LOGO_DIR="/home/jdkzwl/nixos-config/home/fastfetch/logo"
      fi
      
      # 检查 logo 目录是否存在
      if [ ! -d "$LOGO_DIR" ]; then
        echo "nixos"  # 返回内置 logo
        exit 0
      fi
      
      # 统计 .icon 文件数量
      LOGO_COUNT=$(find "$LOGO_DIR" -type f -name "*.icon" | wc -l)
      
      # 如果没有找到 .icon 文件，使用内置 logo
      if [ "$LOGO_COUNT" -eq 0 ]; then
        echo "nixos"
        exit 0
      fi
      
      # 随机选择一个 logo 文件
      RANDOM_LOGO=$(find "$LOGO_DIR" -type f -name "*.icon" | sort -R | head -1)
      
      # 如果成功找到文件，返回文件内容
      if [ -f "$RANDOM_LOGO" ]; then
        cat "$RANDOM_LOGO"
      else
        echo "nixos"  # 如果出错，使用内置 logo
      fi
    '';
  };
  
  # 创建桌面项，方便从菜单启动
  xdg.desktopEntries.fastfetch = {
    name = "Fastfetch System Info";
    genericName = "System Information";
    exec = "${pkgs.kitty}/bin/kitty -e sh -c \"${pkgs.fastfetch}/bin/fastfetch; read -p 'Press Enter to exit...'\"";
    icon = "utilities-system-monitor";
    categories = [ "System" "Monitor" ];
    comment = "Display system information in the terminal";
  };
  
  # 如果您希望在终端启动时自动运行 fastfetch
  programs.bash.initExtra = lib.mkIf config.programs.bash.enable ''
    # 在登录时运行 fastfetch（如果需要）
    # fastfetch
  '';
}
