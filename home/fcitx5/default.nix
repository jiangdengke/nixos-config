{ config, pkgs, ... }:

{
  # 使用新的语法配置输入法
  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    # 最小化依赖项，避免冲突
    fcitx5.addons = with pkgs; [
      fcitx5-rime
      fcitx5-chinese-addons
    ];
  };
  
  # 最小化配置文件
  home-manager.users.jdk = { ... }: {
    xdg.configFile = {
      "fcitx5/profile".text = ''
        [Groups/0]
        Name=默认
        Default Layout=us
        DefaultIM=rime

        [Groups/0/Items/0]
        Name=keyboard-us
        Layout=

        [Groups/0/Items/1]
        Name=rime
        Layout=

        [GroupOrder]
        0=默认
      '';
    };
    
    # 启动脚本
    home.file.".xprofile".text = ''
      fcitx5 -d &
    '';
  };
}
