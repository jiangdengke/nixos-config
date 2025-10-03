{ pkgs, ... }:
{
  services.mako = {
    enable = true;
    package = pkgs.mako;
    settings = {
      anchor = "top-right";
      default-timeout = 5000;
      width = 320;
      height = 120;
      border-radius = 6;
      font = "JetBrains Mono 11";
      background-color = "#1e1e2eff";
      text-color = "#f5f5f5ff";
      border-color = "#7aa2f7ff";
      max-icon-size = 64;
    };
    extraConfig = ''
      [urgency=low]
      border-color=#6c7086ff

      [urgency=high]
      border-color=#f7768eff
      default-timeout=0
    '';
  };
}
