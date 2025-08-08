{ pkgs, ... }: {
  gtk.enable = true;
  gtk.iconTheme = {
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
  };
  home.packages = [ pkgs.hicolor-icon-theme ];
}

