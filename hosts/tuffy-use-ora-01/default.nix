{
  config,
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
    ./secrets
    ./tailscale

    ../common/core
    ../common/nixos

    ../common/users/tuckershea
  ];

  networking.hostName = "tuffy-use-ora-01";
  networking.domain = "constellation.tuckershea.com";
  networking.hostId = "97711b5e";

  system.stateVersion = "24.11";

  users.mutableUsers = false;

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 100;
  };

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
      "/var/lib/tailscale"
    ];
  };
}
