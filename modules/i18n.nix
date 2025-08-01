{ config, lib, pkgs, ... }:

{
  # 设置时区
  time.timeZone = "Asia/Shanghai";

  # 设置国际化属性
  i18n = {
    defaultLocale = "zh_CN.UTF-8";
    
    # 添加支持的区域设置
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "zh_CN.UTF-8/UTF-8"
      "C.UTF-8/UTF-8"
    ];
    
    extraLocaleSettings = {
      LC_ADDRESS = "zh_CN.UTF-8";
      LC_IDENTIFICATION = "zh_CN.UTF-8";
      LC_MEASUREMENT = "zh_CN.UTF-8";
      LC_MONETARY = "zh_CN.UTF-8";
      LC_NAME = "zh_CN.UTF-8";
      LC_NUMERIC = "zh_CN.UTF-8";
      LC_PAPER = "zh_CN.UTF-8";
      LC_TELEPHONE = "zh_CN.UTF-8";
      LC_TIME = "zh_CN.UTF-8";
    };
   }; 
}
