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

    # optionals here...

    ../common/users/tuckershea
  ];

  networking.hostName = "makoto";
  networking.domain = "constellation.tuckershea.com";
  networking.hostId = "cf901365";

  system.stateVersion = "25.05";

  users.mutableUsers = false;

  networking.dhcpcd.extraConfig = ''
    noarp
    option rapid_commit
  '';

  boot.blacklistedKernelModules = [
    "cfg80211"
    "rfkill"
    "8021q"
  ];

  boot.initrd.systemd.enable = true;

  # makoto needs to load some driver for the
  # ethernet interface. I'm not sure which yet
  # (I think at least igc) so I just allow anything.
  security.lockKernelModules = lib.mkForce false;

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
      "/var/lib/systemd/timers"
    ];
  };
}
