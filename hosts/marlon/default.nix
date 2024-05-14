{ modulesPath, lib, pkgs, ... }:
{
  imports = [
    ./boot.nix
    ./docker.nix
    ./hardware-configuration.nix
    ./k3s.nix
    ./secrets.nix

    ../common/core
    ../common/core-nixos

    ../common/optional/auto-upgrade.nix

    ../common/users/root
    ../common/users/tuckershea
  ];

  networking.hostName = "marlon";

  system.stateVersion = "23.11";
}
