{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
};

  outputs = inputs@{ self, nixpkgs, darwin, home-manager }:
  let
    inherit (darwin.lib) darwinSystem;

    nixpkgsConfig = {
      config = { allowUnfree = true; };
    };
  in
  {
    darwinConfigurations."Tuckers-MacBook-Air" = darwinSystem {
      system = "aarch64-darwin";
      modules = [
      	./configuration.nix
        home-manager.darwinModules.home-manager {
          nixpkgs = nixpkgsConfig;
          # `home-manager` config
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.tuckershea = import ./home.nix; 
	}
        ./hosts/Tuckers-MacBook-Air/default.nix
      ];
    };
  };
}
