{ config, lib, pkgs, ... }:

{
  programs.i3status = {
    enable = true;
    
    general = {
      colors = true;
      interval = 5;
    };
    
    modules = {
      # First disable ALL default modules to avoid duplicates
      "ipv6".enable = false;
      "disk /".enable = true;
      "load".enable = false;
      "memory".enable = true;
      "cpu_temperature 0".enable = false;
      "ethernet _first_".enable = false;
      "wireless _first_".enable = true;
      "battery all".enable = false;
      "tztime local".enable = true;
      
      # Now add ONLY the modules you want, with positions
      "cpu_usage" = {
        position = 1;
        settings = {
          format = "CPU: %usage";
        };
      };
      
      "memory" = {
        position = 2;
        settings = {
          format = "RAM: %used | %available";
          threshold_degraded = "1G";
          format_degraded = "MEMORY < %available";
        };
      };
      
      "disk /" = {
        position = 3;
        settings = {
          format = "Disk: %avail";
        };
      };
      
      "wireless _first_" = {
        position = 4;
        settings = {
          format_up = "WiFi: %essid %quality";
          format_down = "WiFi: down";
        };
      };
      
      "battery 0" = {
        position = 5;
        settings = {
          format = "Bat: %status %percentage";
          last_full_capacity = true;
        };
      };
      
      "tztime local" = {
        position = 6;
        settings = {
          format = "%Y-%m-%d %H:%M:%S";
        };
      };
    };
  };
}
