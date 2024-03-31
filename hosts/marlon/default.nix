{ modulesPath, lib, pkgs, ... }:
{
  imports = [
    ./boot.nix
    ./docker.nix
    ./hardware-configuration.nix
    ./secrets.nix

    ../common/core
    ../common/core-nixos

    ../common/users/root
    ../common/users/tuckershea
  ];

  networking.hostName = "marlon";

  system.stateVersion = "23.11";
}
