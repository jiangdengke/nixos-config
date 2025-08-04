{ config, lib, pkgs, ... }:

{
  # 禁用 i3status
  programs.i3status.enable = false;

  # 配置 i3blocks
  home.packages = with pkgs; [
    i3blocks
    font-awesome      # 提供图标支持
    noto-fonts        # 基本字体
    (nerdfonts.override {
      fonts = [ "FiraCode" "SourceCodePro" ];
    })
    acpi              # 用于获取电池状态
    lm_sensors        # 用于获取温度信息
  ];

  # 创建 i3blocks 配置文件
  xdg.configFile."i3blocks/config".text = ''
    # i3blocks config file
    #
    # Global properties
    command=$HOME/.config/i3blocks/scripts/\${BLOCK_NAME}
    separator_block_width=15
    markup=pango

    # CPU使用率
    [cpu]
    label=<span font='Font Awesome 6 Free'>&#xf2db;</span>
    interval=2

    # 内存使用
    [memory]
    label=<span font='Font Awesome 6 Free'>&#xf538;</span>
    interval=3

    # 存储空间
    [disk]
    label=<span font='Font Awesome 6 Free'>&#xf0a0;</span>
    interval=30

    # Wi-Fi状态
    [wifi]
    label=<span font='Font Awesome 6 Free'>&#xf1eb;</span>
    interval=5

    # 电池状态
    [battery]
    interval=5

    # 音量
    [volume]
    label=<span font='Font Awesome 6 Free'>&#xf028;</span>
    interval=1
    signal=10

    # 时间日期
    [time]
    label=<span font='Font Awesome 6 Free'>&#xf017;</span>
    interval=1

    [date]
    label=<span font='Font Awesome 6 Free'>&#xf133;</span>
    interval=60
  '';

  # 在 i3 配置中使用 i3blocks
  xsession.windowManager.i3.config = {
    bars = [
      {
        position = "top";
        statusCommand = "${pkgs.i3blocks}/bin/i3blocks";
        colors = {
          background = "#2E3440";
          statusline = "#ECEFF4";
          separator = "#4C566A";
          focusedWorkspace = {
            border = "#5E81AC";
            background = "#5E81AC";
            text = "#ECEFF4";
          };
          activeWorkspace = {
            border = "#3B4252";
            background = "#3B4252";
            text = "#ECEFF4";
          };
          inactiveWorkspace = {
            border = "#3B4252";
            background = "#3B4252";
            text = "#D8DEE9";
          };
          urgentWorkspace = {
            border = "#BF616A";
            background = "#BF616A";
            text = "#ECEFF4";
          };
        };
        fonts = {
          names = [ "Noto Sans" "Font Awesome 6 Free" "Font Awesome 6 Free Solid" ];
          size = 9.0;
        };
      }
    ];
  };

  # 引入脚本文件
  xdg.configFile = {
    "i3blocks/scripts/cpu".source = ./scripts/cpu;
    "i3blocks/scripts/memory".source = ./scripts/memory;
    "i3blocks/scripts/disk".source = ./scripts/disk;
    "i3blocks/scripts/wifi".source = ./scripts/wifi;
    "i3blocks/scripts/battery".source = ./scripts/battery;
    "i3blocks/scripts/volume".source = ./scripts/volume;
    "i3blocks/scripts/time".source = ./scripts/time;
    "i3blocks/scripts/date".source = ./scripts/date;
  };
}
