{
  services.dae = {
    enable = true;
    # 必须是带引号的运行时路径，不能改成 Nix 路径字面量或 readFile。
    # NixOS 通过 systemd LoadCredential 读取，不把文件内容写入 Nix store。
    configFile = "/etc/dae/config.dae";
  };
}
