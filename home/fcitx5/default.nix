{ pkgs, lib, ... }:
{
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.fcitx5-with-addons = pkgs.qt6Packages.fcitx5-with-addons;
    fcitx5.addons = [
      pkgs.fcitx5-rime
      pkgs.fcitx5-table-extra
      pkgs.qt6Packages.fcitx5-chinese-addons
      pkgs.qt6Packages.fcitx5-pinyin-moegirl
      pkgs.qt6Packages.fcitx5-pinyin-zhwiki
    ];
  };
  home.sessionVariables = {
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
    SDL_IM_MODULE = "fcitx";
    GLFW_IM_MODULE = lib.mkForce "fcitx";
  };
  home.file = {
    ".config/fcitx5/conf/classicui.conf".source = ./classicui.conf;
    ".local/share/fcitx5/themes/Nord/theme.conf".text = builtins.readFile ./theme.conf; # 直接读取文件内容
    # 或者
    # ".local/share/fcitx5/themes/Nord/theme.conf".source = ./theme.conf;
  };
}
