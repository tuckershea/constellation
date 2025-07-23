{
  config,
  modulesPath,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./actual.nix
    ./boot.nix
    ./disks.nix
    ./hardware-configuration.nix
    ./immich.nix
    ./keycloak
    ./mailrise
    ./paperless.nix
    ./secrets
    ./tailscale

    ../common/core
    ../common/nixos

    # optionals here...

    ../common/users/tuckershea
  ];

  networking.hostName = "spencer";
  networking.domain = "constellation.tuckershea.com";
  networking.hostId = "8425e349";

  platforms.hetzner = {
    enable = true;

    ipv6.enable = true;
    ipv6.subnet = "2a01:4f9:c010:eb41::/64";
  };

  system.stateVersion = "25.05";

  users.mutableUsers = false;

  security.acme = {
    acceptTerms = true;
    defaults.email = "acme" + "@" + "tuckershea.com";
    defaults.renewInterval = "weekly";
  };

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

  # This is really just an easy way
  # to receive on port 25 (smtp) instead
  # of port 8025 (mailrise)
  services.opensmtpd = {
    enable = true;
    setSendmail = false;  # common/nixos/mail.nix prefers msmtp
    serverConfiguration = ''
      # forward all mail to mailrise
      listen on 0.0.0.0 port 25
      action "relay" relay host "localhost:8025"
      match from any for any action "relay"
    '';
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
      "/var/lib/acme"
      "/var/lib/systemd/timers"
      config.services.postgresql.dataDir
    ];
  };
}
