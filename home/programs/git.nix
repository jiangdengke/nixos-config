{
  pkgs,
  ...
}: {
  home.packages = [pkgs.gh];

  programs.git = {
    enable = true;

    settings = {
      user.name = "jiangdengke";
      user.email = "jiang1728439852@gmail.com";
    };
  };
}
