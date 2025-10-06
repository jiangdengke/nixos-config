{ pkgs, ... }:
{
  home.packages = with pkgs; [ swaybg coreutils findutils procps ];

  home.file.".local/bin/swaybg-random.sh" = {
    force = true;
    text = builtins.readFile ./swaybg-random.sh;
    executable = true;
  };
}
