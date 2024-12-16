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
    ./hardware-configuration.nix
    ./secrets.nix

    ../common/core
    ../common/nixos

    # optionals here...

    ../common/users/tuckershea
  ];

  networking.hostName = "roland";
  networking.domain = "constellation.tuckershea.com";
  networking.hostId = "d310061c";

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
      "/var/lib/nixos"  # preserve uids/gids between reboots
    ];
  };
}
