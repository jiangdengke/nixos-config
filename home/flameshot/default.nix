{ config, lib, pkgs, ... }:

{
  # 安装 Flameshot 截图工具
  home.packages = with pkgs; [
    flameshot
  ];

  # 配置 Flameshot
  services.flameshot = {
    enable = true;
    settings = {
      General = {
        disabledTrayIcon = false;
        showStartupLaunchMessage = false;
        showHelp = false;
        saveAsFileExtension = "png";
        savePath = "${config.home.homeDirectory}/Pictures/Screenshots";
        uiColor = "#2980b9";
        contrastUiColor = "#f1c40f";
        # 确保贴图功能启用
        pinImageToClipboard = true;  # 这会让截图也自动复制到剪贴板
        checkForUpdates = false;     # 在 NixOS 中禁用更新检查
      };
      Shortcuts = {
        TYPE_COPY = "Ctrl+C";
        TYPE_SAVE = "Ctrl+S";
        TYPE_SAVE_AS = "Ctrl+Shift+S";
        TYPE_PIN = "Ctrl+P";         # 添加贴图快捷键
      };
    };
  };
  
  # 确保截图保存目录存在
  home.activation.createScreenshotDir = lib.hm.dag.entryAfter ["writeBoundary"] ''
    $DRY_RUN_CMD mkdir -p ${config.home.homeDirectory}/Pictures/Screenshots
  '';
}
