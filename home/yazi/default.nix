{ config, pkgs, ... }:

{
  imports = [
    ./settings.nix
    ./keymap.nix
    ./theme.nix
    ./packages.nix
  ];
  
  # 基础配置
  programs.yazi = {
    enable = true;
    
    # Shell 集成
    enableZshIntegration = true;    # 如果使用 Zsh，否则设为 false
    
    # 包配置
    package = pkgs.yazi.withExtras;  # 包含预览所需的额外依赖
    
    # Shell 包装器名称（可选）
    shellWrapperName = "y";  # 默认为 "ya"
  };
  
}
