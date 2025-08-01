{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    
    catppuccin-bat = {
      url = "github:catppuccin/bat";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, catppuccin-bat, ... }@inputs: {
    # 确保在这里引入 catppuccin-bat ^^^^^^^^^^^^^

    packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;
    packages.x86_64-linux.default = self.packages.x86_64-linux.hello;
    
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./nixos/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.jdk = ./home;
            
            # 取消注释并修改这一行，传递 catppuccin-bat 到 home-manager
            home-manager.extraSpecialArgs = {
              inherit (inputs) catppuccin-bat;
            };
          }
        ];
      };
    };
  };
}
