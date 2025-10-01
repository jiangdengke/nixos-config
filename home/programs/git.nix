{
  pkgs,
  ...
}: {
  home.packages = [pkgs.gh];

  programs.git = {
    enable = true;

    userName = "jiangdengke";
    userEmail = "jiang1728439852@gmail.com";

    extraConfig = {
      core.askPass = "";
      credential.helper = "!${pkgs.gh}/bin/gh auth git-credential";
      url."git@github.com:".insteadOf = "https://github.com/";
      url."ssh://git@github.com/".insteadOf = "https://github.com/";
    };
  };
}
