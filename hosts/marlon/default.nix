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
    ./docker.nix
    ./hardware-configuration.nix
    ./mailrise.nix
    ./secrets.nix
    ./terraria.nix

    ../common/core
    ../common/nixos

    # optionals here...

    ../common/users/tuckershea
  ];

  networking.hostName = "marlon";
  networking.domain = "constellation.tuckershea.com";
  networking.hostId = "c8215d44";

  system.stateVersion = "23.11";

  users.mutableUsers = false;

  services.tailscaleAutoconnect.enable = lib.mkForce false;
  services.tailscale = {
    enable = true;
    openFirewall = true;
    useRoutingFeatures = "server";
    authKeyFile = config.sops.secrets.tailscale_key.path;

    # Reconfigure everything on restart to fake declarativeness
    # Note: we don't use extraUpFlags --reset because
    # tailscale up is only re-run when the machine is not connected
    # to the tailnet, not on every configuration change.
    extraDaemonFlags = [
      "--statedir=/var/lib/tailscale"
    ];
    extraSetFlags = [
      "--webclient=false"
    ];
    extraUpFlags = [
      "--accept-dns"
      "--accept-risk=all"
      "--accept-routes"
      "--advertise-exit-node"
      "--advertise-routes="
      "--exit-node="
      "--exit-node-allow-lan-access=false"
      "--hostname=${config.networking.hostName}-${config.networking.hostId}"
      "--shields-up=false"
      "--ssh=false"
      "--timeout=30s"
      "--reset"
    ];
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
