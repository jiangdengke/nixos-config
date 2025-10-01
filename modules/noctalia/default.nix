{ config, pkgs, inputs, ... }:

let
  inherit (pkgs.stdenv.hostPlatform) system;
  noctaliaPkg = inputs.noctalia.packages.${system}.default;
in
{
  imports = [ inputs.noctalia.nixosModules.default ];

  environment.systemPackages = [ noctaliaPkg ];

  services.noctalia-shell = {
    enable = true;
  };
}
