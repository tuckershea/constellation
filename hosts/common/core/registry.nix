{ inputs, ... }:
{
  nix.registry = {
    nixpkgs = {
      from = { id = "nixpkgs"; type = "indirect"; };
      flake = inputs.nixpkgs;
    };
  };
}
