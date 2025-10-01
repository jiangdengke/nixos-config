{ pkgs, ... }:

let
  font = "JetBrainsMono Nerd Font";
in
{
  programs.ghostty = {
    enable = true;
    settings = {
      "font-family" = font;
      "font-size" = 11;
      "theme" = "nord";
      "background" = "#1f2332";
      "foreground" = "#e5e9f0";
      "background-opacity" = 0.92;
      "cursor-style" = "bar";
      "cursor-color" = "#88c0d0";
      "cursor-text" = "#2e3440";
      "selection-background" = "#88c0d0";
      "selection-foreground" = "#2e3440";
      "window-padding-x" = 5;
      "window-padding-y" = 5;
      "window-decoration" = "none";
      "gtk-tabs-location" = "hidden";
      "confirm-close-surface" = false;
      keybind = [
        "enter=text:\\r"
        "backspace=text:\\x7f"
      ];
    };
  };

  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
  ];
}
