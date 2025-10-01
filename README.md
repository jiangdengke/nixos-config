# nixos-config

## 项目结构概览

- `flake.nix` / `flake.lock`：定义并锁定 Flake 输入，导出 NixOS 主机与示例包。
- `home/`：Home Manager 用户态配置入口，按功能拆分（开发环境、GTK、Niri、Waybar、Fcitx5 等）。
  - `default.nix`：汇总所有用户模块、基本环境变量与 `stateVersion`。
  - `dev/`：Go 与 Python 工具链设置。
  - `programs/`：常用程序（`common.nix`）与 Git 配置（`git.nix`）。
  - `niri/`：Niri 合成器配置、壁纸、swaylock 与相关用户服务。
  - `waybar/`：Waybar 外观、脚本和 polkit-gnome agent。
  - 其他目录（`gtk/`、`zsh/`、`fastfetch/`、`ghostty/`、`rofi/`、`yazi/`、`nvim/` 等）分别管理对应应用或主题。
- `modules/`：系统级 NixOS 模块（启动、字体、输入法、本地化、网络、常用包、用户、niri、nix-ld、dae 代理等）。
- `nixos/`：主机入口 `configuration.nix`（整合硬件和模块）及自动生成的 `hardware-configuration.nix`。
- `.git/`：Git 元数据。
