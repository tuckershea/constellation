{
  config,
  lib,
  ...
}:
{
  sops.secrets.tailscale_authkey = {
    sopsFile = ./authkey.+makoto.enc;
    format = "binary";
  };

  services.tailscaleAutoconnect.enable = lib.mkForce false;
  services.tailscale = {
    enable = true;
    openFirewall = true;
    useRoutingFeatures = "server";
    authKeyFile = config.sops.secrets.tailscale_authkey.path;

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
}

