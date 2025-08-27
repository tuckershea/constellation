{
  outputs,
  ...
}:
{
  imports = [
    ./auto-upgrade.nix
    ./cis-hardening.nix
    ./mail.nix
    ./network.nix
    ./nix.nix
    ./no-wait-online.nix # mitigate NetworkManager Wait-Online failure
    ./node-exporter.nix
    ./openssh.nix
    ./sudo-no-password.nix # don't require password for sudo
    ./tailscale.nix

    outputs.nixosModules.hetzner
  ];

  # Really effective way of adding fast swap:
  # most memory compresses pretty well.
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 100;
  };

  # Prefer full NTP for higher-accuracy time
  services.chrony.enable = true;

  services.nginx = {
    # Nice defaults
    recommendedTlsSettings = true;
    recommendedOptimisation = true;
    recommendedGzipSettings = true;
    recommendedUwsgiSettings = true;
    recommendedProxySettings = true;
    recommendedBrotliSettings = true;
  };
}
