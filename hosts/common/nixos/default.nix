{
  imports = [
    ./auto-upgrade.nix
    ./network.nix
    ./nix.nix
    ./no-wait-online.nix # mitigate NetworkManager Wait-Online failure
    ./node-exporter.nix
    ./openssh.nix
    ./sudo-no-password.nix # don't require password for sudo
    ./tailscale.nix
  ];
}
