{ ... }:
{
  imports = [ ./swaybg ];

  xdg.configFile."niri/config.kdl" = {
    source = ./config.kdl;
  };
}
