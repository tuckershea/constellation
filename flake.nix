{
  description = "My infrastructure";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    sops-nix.url = "github:mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    impermanence.url = "github:nix-community/impermanence";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    darwin,
    home-manager,
    sops-nix,
    nixvim,
    impermanence,
    disko,
  }: let
    inherit (self) outputs;
    inherit (darwin.lib) darwinSystem;
    inherit (nixpkgs.lib) nixosSystem;
  in {
    nixosModules = import ./modules/nixos;
    darwinModules = import ./modules/darwin;
    homeManagerModules = import ./modules/home-manager;

    overlays = import ./overlays {inherit inputs outputs;};

    darwinConfigurations."elmira" = darwinSystem {
      system = "aarch64-darwin";
      specialArgs = {inherit (self) inputs outputs;};
      modules = [
        ./hosts/elmira
        home-manager.darwinModules.home-manager
        {
          home-manager.users.tuckershea = import ./home/tuckershea/elmira.nix;
        }
      ];
    };

    nixosConfigurations."marlon" = nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit (self) inputs outputs;};
      modules = [
        ./hosts/marlon
        sops-nix.nixosModules.sops
        home-manager.nixosModules.home-manager
        impermanence.nixosModules.impermanence
        disko.nixosModules.disko
        {
          home-manager.users.tuckershea = import ./home/tuckershea/marlon.nix;
        }
      ];
    };

    nixosConfigurations."vic" = nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit (self) inputs outputs;};
      modules = [
        ./hosts/vic
        sops-nix.nixosModules.sops
        home-manager.nixosModules.home-manager
        {
          home-manager.users.tuckershea = import ./home/tuckershea/vic.nix;
        }
      ];
    };
  };
}
