{ pkgs, ... }:
{
  # 禁用 mako，改用 swaync
  services.mako.enable = false;

  # 启用 swaync (Sway Notification Center)
  services.swaync = {
    enable = true;
    settings = {
      # 通知行为
      positionX = "right";
      positionY = "top";
      timeout = 5;
      timeout-low = 3;
      timeout-critical = 0;

      # 通知中心
      control-center-margin-top = 10;
      control-center-margin-bottom = 10;
      control-center-margin-right = 10;
      control-center-margin-left = 10;
      control-center-width = 400;
      control-center-height = 600;

      # 通知样式
      notification-window-width = 400;
      notification-icon-size = 48;
      notification-body-image-height = 100;
      notification-body-image-width = 200;

      # 键盘快捷键
      keyboard-shortcuts = true;
      image-visibility = "when-available";
      transition-time = 200;

      # 勿扰模式
      hide-on-clear = false;
      hide-on-action = true;
      script-fail-notify = true;

      # 通知分组
      widgets = [
        "inhibitors"
        "title"
        "dnd"
        "notifications"
      ];
    };
    style = builtins.readFile ../swaync/style.css;
  };
}
