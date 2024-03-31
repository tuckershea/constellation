{
  imports = [
    ./network.nix
    ./no-wait-online.nix  # mitigate NetworkManager Wait-Online failure
    ./node-exporter.nix
    ./sudo-no-password.nix  # don't require password for sudo
    ./tailscale.nix
  ];
}
