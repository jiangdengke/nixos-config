# 所有主机共用的系统模块
# GPU 驱动（nvidia-gpu.nix / intel-gpu.nix）由各主机在 hosts/<主机名>/default.nix 里按需 import
{
  imports = [
    ./nix.nix
    ./boot.nix
    ./power.nix
    ./i18n.nix
    ./fonts.nix
    ./networking.nix
    ./desktop.nix
    ./niri
    ./packages.nix
    ./nix-ld.nix
    ./users.nix
    ./home-manager.nix
  ];
}
