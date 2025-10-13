{ pkgs, ... }:
{
  services.mako = {
    enable = true;
    package = pkgs.mako;
    settings = {
      # 位置和尺寸
      anchor = "top-right";
      width = 350;
      height = 150;
      margin = "15";
      padding = "15";

      # 样式
      border-radius = 12;
      border-size = 2;
      font = "JetBrainsMonoNL Nerd Font 11";

      # 配色 - 与 rofi 统一的柔和风格
      background-color = "#1e1e2edd";
      text-color = "#e0def4";
      border-color = "#9ccfd8";

      # 图标
      max-icon-size = 48;
      icon-location = "left";

      # 行为
      default-timeout = 5000;
      ignore-timeout = false;

      # 分组
      group-by = "app-name";
      max-visible = 3;
    };
    extraConfig = ''
      [urgency=low]
      border-color=#6e6a86
      background-color=#1e1e2edd

      [urgency=normal]
      border-color=#9ccfd8
      background-color=#1e1e2edd

      [urgency=high]
      border-color=#eb6f92
      background-color=#1e1e2edd
      text-color=#eb6f92
      default-timeout=0

      [app-name="Spotify"]
      border-color=#f6c177
    '';
  };
}
