{ config, pkgs, ... }:

# 拆分设置/主题/快捷键，便于分别维护
let
  settings = import ./yazi.nix;
  theme = import ./theme.nix;
  keymap = import ./keymap.nix;
in
{
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    shellWrapperName = "y"; # 方便通过 y 命令启动 Yazi
    flavors = { };
    settings = settings;
    theme = theme;
    keymap = keymap;
  };

  # 图像预览依赖（与 README 功能描述保持一致）
  home.packages = with pkgs; [
    ueberzugpp
  ];
}
