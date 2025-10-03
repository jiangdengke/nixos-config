{
  pkgs,
  ...
}: {
  home.packages = [pkgs.gh];

  programs.git = {
    enable = true;

    userName = "jiangdengke";
    userEmail = "jiang1728439852@gmail.com";
  };
}
