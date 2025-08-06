{ config, pkgs, ... }:

{
  # 启用蓝牙硬件支持
  hardware.bluetooth.enable = true;

  # 安装蓝牙工具
  environment.systemPackages = with pkgs; [
    bluez             # 蓝牙协议栈
    bluez-tools       # 提供一些附加的蓝牙工具 (可选)
    bluetui
  ];

}

