{
  description = "jdk 的 NixOS 配置（Niri + Home Manager）";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    { nixpkgs, home-manager, ... }:
    {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt;

      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        # 平台由主机的 hardware-configuration.nix 决定。
        modules = [
          home-manager.nixosModules.home-manager
          ./hosts/nixos
        ];
      };
    };
}
