{ config, pkgs, ... }:

{
  # 蓝牙硬件支持
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;  # 开机自动打开蓝牙
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        Experimental = true;
      };
    };
  };
  
  # 音频系统服务
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;  # 如果需要 JACK 支持
  };
  
  # 系统级服务
  services.blueman.enable = true;  # 蓝牙管理服务
  
  # 系统级软件包
  environment.systemPackages = with pkgs; [
    bluez
    bluez-tools
    blueman
    
    # 基本音频工具
    pamixer
    playerctl
  ];
}
