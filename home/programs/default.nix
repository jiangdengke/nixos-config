{ config, pkgs, ... }:

{
  # 导入所有程序配置
  imports = [
    ./common.nix   # 常用软件包
    ./git.nix      # Git 配置
#    ./media.nix    # 媒体软件配置
    ./xdg.nix      # XDG 配置
  ];
}
