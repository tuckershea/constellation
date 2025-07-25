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
  
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
    nix-minecraft.inputs.nixpkgs.follows = "nixpkgs";
    
    nur.url = "github:nix-community/NUR";
    nur.inputs.nixpkgs.follows = "nixpkgs";
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
    nix-index-database,
    nix-minecraft,
    nur,
  }: let
    inherit (self) outputs;
    inherit (darwin.lib) darwinSystem;
    inherit (nixpkgs.lib) nixosSystem;

    forAllSystems = nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed;
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
          home-manager.users.tuckershea.imports = [
            ./home/tuckershea/shell
            ./home/tuckershea/graphical
            ./home/tuckershea/darwin
            ./home/tuckershea/hosts/elmira
          ];
          home-manager.extraSpecialArgs = {inherit inputs outputs;};
        }
        nur.modules.darwin.default
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
        nix-minecraft.nixosModules.minecraft-servers
        {
          home-manager.users.tuckershea.imports = [
            ./home/tuckershea/shell
          ];
          home-manager.extraSpecialArgs = {inherit inputs outputs;};
        }
        nur.modules.nixos.default
      ];
    };

    nixosConfigurations."spencer" = nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit (self) inputs outputs;};
      modules = [
        ./hosts/spencer
        sops-nix.nixosModules.sops
        home-manager.nixosModules.home-manager
        impermanence.nixosModules.impermanence
        disko.nixosModules.disko
        {
          home-manager.users.tuckershea.imports = [
            ./home/tuckershea/shell
          ];
          home-manager.extraSpecialArgs = {inherit inputs outputs;};
        }
        nur.modules.nixos.default
      ];
    };

    nixosConfigurations."roland" = nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit (self) inputs outputs;};
      modules = [
        ./hosts/roland
        sops-nix.nixosModules.sops
        home-manager.nixosModules.home-manager
        impermanence.nixosModules.impermanence
        disko.nixosModules.disko
        {
          home-manager.users.tuckershea.imports = [
            ./home/tuckershea/shell
          ];
          home-manager.extraSpecialArgs = {inherit inputs outputs;};
        }
        nur.modules.nixos.default
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
          home-manager.users.tuckershea.imports = [
            ./home/tuckershea/shell
            ./home/tuckershea/graphical
          ];
          home-manager.extraSpecialArgs = {inherit inputs outputs;};
        }
        nur.modules.nixos.default
      ];
    };

    nixosConfigurations."tuffy-use-ora-01" = nixosSystem {
      system = "aarch64-linux";
      specialArgs = {inherit (self) inputs outputs;};
      modules = [
        ./hosts/tuffy-use-ora-01
        sops-nix.nixosModules.sops
        home-manager.nixosModules.home-manager
        impermanence.nixosModules.impermanence
        disko.nixosModules.disko
        nix-minecraft.nixosModules.minecraft-servers
        {
          home-manager.users.tuckershea.imports = [
            ./home/tuckershea/shell
          ];
          home-manager.extraSpecialArgs = {inherit inputs outputs;};
        }
        nur.modules.nixos.default
      ];
    };

    nixosConfigurations."makoto" = nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit (self) inputs outputs;};
      modules = [
        ./hosts/makoto
        sops-nix.nixosModules.sops
        home-manager.nixosModules.home-manager
        impermanence.nixosModules.impermanence
        disko.nixosModules.disko
        {
          home-manager.users.tuckershea.imports = [
            ./home/tuckershea/shell
          ];
          home-manager.extraSpecialArgs = {inherit inputs outputs;};
        }
        nur.modules.nixos.default
      ];
    };

    top =
          let
            nixtop = inputs.nixpkgs.lib.genAttrs
              (builtins.attrNames inputs.self.nixosConfigurations)
              (attr: inputs.self.nixosConfigurations.${attr}.config.system.build.toplevel);
            darwintop = inputs.nixpkgs.lib.genAttrs
              (builtins.attrNames inputs.self.darwinConfigurations)
              (attr: inputs.self.darwinConfigurations.${attr}.system);
          in
          nixtop // darwintop;

    packages = forAllSystems(system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
        {
          rotate-tailscale-keys = pkgs.writeShellApplication {
            name = "rotate-tailscale-keys";
            runtimeInputs = [
              pkgs.sops
              pkgs.tailscale
            ];
            text = builtins.readFile ./bin/rotate_tailscale_keys.sh;
          };
        }
    );

    apps = forAllSystems (system:
      let
        pkgs = import nixpkgs { inherit system; };
        mkApp = program: {
          type = "app";
          program = "${self.packages.${system}.${program}}/bin/${program}";
        };
      in
        {
          rotate-tailscale-keys = mkApp "rotate-tailscale-keys";
        }
    );
  };
}
