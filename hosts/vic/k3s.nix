{ pkgs, config, ... }:
{
  services.k3s = {
    enable = true;
    role = "agent";
    tokenFile = config.sops.secrets.k3s_token.path;
    serverAddr = "https://marlon:6443";
  };

  services.k3s.extraFlags = toString [
    "--flannel-iface=tailscale0"
  ];
}
