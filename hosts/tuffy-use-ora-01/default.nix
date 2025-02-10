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
    ./minecraft.nix
    ./secrets

    ../common/core
    ../common/nixos

    ../common/users/tuckershea
  ];

  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];

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
      "--hostname=${config.networking.hostName}"
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
