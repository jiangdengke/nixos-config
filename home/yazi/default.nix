{ config, pkgs, ... }:
let
  settings = import ./yazi.nix;
  theme = import ./theme.nix;
  keymap = import ./keymap.nix;
in
{
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    shellWrapperName = "y";
    flavors = { };
    settings = settings;
    theme = theme;
    keymap = keymap;
  };
  # 在您的 packages.nix 中添加
home.packages = with pkgs; [
  # 其他包...
  
  # 支持 Alacritty 中的图像预览
  ueberzugpp  # 注意这是 Überzug++ (C++版本)，不是旧版的 ueberzug
  
];
}
