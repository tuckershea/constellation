{
  modulesPath,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./boot.nix
    ./disks.nix
    ./docker.nix
    ./hardware-configuration.nix
    ./secrets.nix
    ./terraria.nix

    ../common/core
    ../common/core-nixos

    ../common/optional/auto-upgrade.nix

    ../common/users/root
    ../common/users/tuckershea
  ];

  networking.hostName = "marlon";
  networking.hostId = "c8215d44";

  system.stateVersion = "23.11";

  users.mutableUsers = false;

  services.tailscaleAutoconnect.ephemeral = true;

  environment.persistence."/persist" = {
    hideMounts = true;
    files = [
      "/etc/machine-id"
      "/etc/ssh/ssh_host_rsa_key"
      "/etc/ssh/ssh_host_rsa_key.pub"
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_ed25519_key.pub"
    ];
  
    directories = [
      "/var/log"
    ];
  };
}
