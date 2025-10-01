{ config, pkgs, inputs, ... }:

{
  imports = [ inputs.noctalia.homeModules.default ];

  programs.noctalia-shell = {
    enable = true;
    settings = {
      bar = {
        density = "compact";
        position = "top";
        showCapsule = false;
        widgets = {
          left = [
            {
              id = "SidePanelToggle";
              useDistroLogo = true;
            }
            {
              id = "ActiveWindow";
            }
            {
              id = "Workspace";
              hideUnoccupied = true;
            }
          ];
          center = [
            {
              id = "MediaMini";
            }
          ];
          right = [
            { id = "NotificationHistory"; }
            { id = "WiFi"; }
            { id = "Bluetooth"; }
            { id = "Battery"; }
            { id = "Volume"; }
            { id = "Brightness"; }
            {
              id = "Clock";
              formatHorizontal = "HH:mm";
              usePrimaryColor = true;
            }
            { id = "ControlCenter"; }
          ];
        };
      };
      appLauncher = {
        position = "center";
        backgroundOpacity = 0.95;
      };
      notifications.location = "top_right";
      general.radiusRatio = 0.25;
      colorSchemes.predefinedScheme = "Noctalia (default)";
    };
  };

  home.packages = with pkgs; [
    brightnessctl
  ];
}
