{ inputs, outputs, ... }:
{
  imports = [
    ./locale.nix
    ./nix.nix
    ./zsh.nix
  ];

  home-manager.extraSpecialArgs = { inherit inputs outputs; };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };
}
