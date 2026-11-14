{ ... }:

{
  # 核心系统配置
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    substituters = [
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      "https://cache.nixos.org/"
    ];
    # 两个缓存均使用 NixOS 官方签名，信任密钥沿用 NixOS 默认值。
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  nixpkgs.config.allowUnfree = true;

  # 兼容仍引用 libsForQt5.fcitx5-with-addons 的旧代码，指向 Qt6 版本
  nixpkgs.overlays = [
    (final: prev: {
      libsForQt5 = (prev.libsForQt5 or { }) // {
        fcitx5-with-addons = prev.qt6Packages.fcitx5-with-addons;
      };
    })
  ];
}
