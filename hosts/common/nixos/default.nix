{
  outputs,
  ...
}:
{
  imports = [
    ./auto-upgrade.nix
    ./cis-hardening.nix
    ./clamav.nix
    ./network.nix
    ./nix.nix
    ./no-wait-online.nix # mitigate NetworkManager Wait-Online failure
    ./node-exporter.nix
    ./openssh.nix
    ./sudo-no-password.nix # don't require password for sudo
    ./tailscale.nix

    outputs.nixosModules.hetzner
  ];

  # Prefer full NTP for higher-accuracy time
  services.chrony.enable = true;
}
