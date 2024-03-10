{
  description = "My infrastructure";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, darwin, home-manager }:
  let
    inherit (self) outputs;
    inherit (darwin.lib) darwinSystem;
    inherit (nixpkgs.lib) nixosSystem;
  in
  {
    nixosModules = import ./modules/nixos;
    darwinModules = import ./modules/darwin;
    homeManagerModules = import ./modules/home-manager;

    overlays = import ./overlays { inherit inputs outputs; };

    darwinConfigurations."elmira" = darwinSystem {
      system = "aarch64-darwin";
      modules = [
        ./hosts/elmira
        home-manager.darwinModules.home-manager
        {
          home-manager.users.tuckershea = import ./home/tuckershea/elmira.nix; 
        }
      ];
    };

    nixosConfigurations."marlon" = nixosSystem {
      # DigitalOcean droplet
      system = "x86_64-linux";
      modules = [
        ./hosts/marlon
        home-manager.nixosModules.home-manager
        {
          home-manager.users.tuckershea = import ./home/tuckershea/marlon.nix;
        }
      ];
    };
  };
}
