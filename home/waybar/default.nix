{config, pkgs, ...}:
{

  home.packages = [ pkgs.brightnessctl ];

    home.file.".config/waybar" = {
  # 指向当前 default.nix 同级的 waybar 目录
  source = ./waybar;

  # 递归地映射目录结构，目录下的每个文件都会被 symlink
  recursive = true;
};

}
