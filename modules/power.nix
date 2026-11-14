{ ... }:

{
  services.logind.settings.Login = {
    HandleLidSwitch = "ignore"; # 笔记本合上盖子不休眠
    HandleSuspendKey = "ignore";
    HandleHibernateKey = "ignore";
    IdleAction = "ignore";
  };

  # 保留 NixOS 电源管理，但不让 powertop 自动调整
  powerManagement = {
    enable = true;
    powertop.enable = false;
  };

  # 减少内存压力落到磁盘 swap 时的卡顿。
  zramSwap.enable = true;
}
