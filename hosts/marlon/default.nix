{ modulesPath, lib, pkgs, ... }:
{
  imports = [
    # DigitalOcean config
    (modulesPath + "/virtualisation/digital-ocean-config.nix")

    ../common/core

    ./secrets.nix

    ../common/users/tuckershea
  ];

  networking.hostName = "marlon";

  system.stateVersion = "24.05";
}
