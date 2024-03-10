{ inputs, outputs, ... }:
{
  imports = [
    ./git.nix
    ./locale.nix
    ./nix.nix
    ./openssh.nix
    ./zsh.nix
  ];

  home-manager.extraSpecialArgs = { inherit inputs outputs; };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };
}
