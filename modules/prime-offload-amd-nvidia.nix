{ config, lib, pkgs, ... }:

let
  # === 必改：用 lspci 查到的真实 Bus ID ===
  # 示例: lspci | egrep "VGA|3D|Display"
  amdgpuBusId = "PCI:5:0:0";  # ← AMD (通常 iGPU)
  nvidiaBusId = "PCI:1:0:0";  # ← NVIDIA (通常 dGPU)

  # === 必改：你的用户名 ===
  user = "jdk";
in
{
  # 拉起 nvidia 驱动包（Wayland 也需要）
  services.xserver.videoDrivers = [ "nvidia" ];


  # 图形栈（24.11+ 推荐用 hardware.graphics；老版本可用 hardware.opengl）
  hardware.graphics = {
    enable = true;
    enable32Bit = true;         # 给 Steam/Proton 32 位用
    extraPackages = with pkgs; [
      vaapiVdpau
      libvdpau-va-gl
      # 如需 nvidia 的 VAAPI（实验性/兼容性取决驱动）
      # nvidia-vaapi-driver
    ];
  };

  hardware.nvidia = {
    modesetting.enable = true;

    # 省电相关（建议）
    powerManagement.enable = true;
    powerManagement.finegrained = true;

    # 专有驱动更稳（Wayland 兼容性目前普遍好于开源内核模块）
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    # ★ PRIME Offload（AMD 驱屏，NVIDIA 只在需要时计算）
    prime = {
      offload.enable = true;
      inherit amdgpuBusId nvidiaBusId;
    };
  };

  # Wayland/NVIDIA 常用环境变量
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";                 # Electron/Chromium 走 Wayland
    GBM_BACKEND = "nvidia-drm";           # 新驱动多半不需要，但设上更稳
    __GLX_VENDOR_LIBRARY_NAME = "nvidia"; # GLX 选择 nvidia
    WLR_NO_HARDWARE_CURSORS = "1";        # 光标异常时保底；正常可删
  };

  # 亮度/显卡权限（可选）
  users.users.${user}.extraGroups = (config.users.users.${user}.extraGroups or []) ++ [ "video" ];
}

