{ config, lib, pkgs, ... }:

let
  # 必改：lspci 查到后转成十进制格式 PCI:A:B:C
  amdgpuBusId = "PCI:5:0:0";  # AMD（多是 iGPU）
  nvidiaBusId = "PCI:1:0:0";  # NVIDIA（多是 dGPU）

  user = "jdk";               # 你的用户名
in
{
  services.xserver.videoDrivers = [ "nvidia" ];


  boot.blacklistedKernelModules = [ "nouveau" ];

  # 25.11 用 hardware.graphics（老版叫 hardware.opengl）
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      vaapiVdpau
      libvdpau-va-gl
      # nvidia-vaapi-driver  # 需要时再打开
    ];
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = true;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    prime = {
      offload.enable = true;
      inherit amdgpuBusId nvidiaBusId;
    };
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  # ★ 修正点：不要读自己，直接追加 video 组
  users.users.${user}.extraGroups = lib.mkAfter [ "video" ];
}

