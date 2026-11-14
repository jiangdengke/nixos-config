{ pkgs, ... }:

{
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gnome
      xdg-desktop-portal-gtk
    ];
    config = {
      common.default = [
        "gnome"
        "gtk"
      ];
      niri = {
        default = [ "gnome" "gtk" ];
        "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
      };
    };
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  services.libinput.enable = true;
  services.udisks2.enable = true;

  # LocalSend 的接收与发现需要 TCP/UDP 53317。
  programs.localsend = {
    enable = true;
    openFirewall = true;
  };

  environment.variables = {
    EDITOR = "nvim";
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "24";
  };
}
