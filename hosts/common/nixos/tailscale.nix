{
  outputs,
  config,
  ...
}: {
  imports = [outputs.nixosModules.tailscale-autoconnect];

  # Requires sops.secrets.tailscale_key to exist!

  services.tailscaleAutoconnect = {
    enable = true;
    authkeyFile = config.sops.secrets.tailscale_authkey.path;
    loginServer = "https://login.tailscale.com";
  };
}
