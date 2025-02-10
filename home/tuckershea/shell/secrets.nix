{
  inputs,
  lib,
  pkgs,
  ...
}:
let
  inherit (pkgs) stdenv;
in
{
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  sops = {
    age.keyFile = lib.mkMerge [
      (lib.mkIf stdenv.isDarwin "/Users/tuckershea/.age-key.txt")
      (lib.mkIf stdenv.isLinux "/home/tuckershea/.age-key.txt")
    ];
  };
}
