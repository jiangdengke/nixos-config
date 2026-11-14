# 所有账户共用的 Shell 设置；账户定义放在各主机配置中。
{
  programs.zsh = {
    enable = true;
    # 交给 Home Manager 配置的 Zim completion 模块处理。
    enableCompletion = false;
  };
}
