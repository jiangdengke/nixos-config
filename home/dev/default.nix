{ pkgs, ... }: 
{
    home.packages = [ 
         pkgs.uv 
         pkgs.python314
    ]; 
}
