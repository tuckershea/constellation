{
  ...
}:
{
  sops.secrets.tailscale_authkey = {
    sopsFile = ./authkey.+roland.enc;
    format = "binary";
  };

  services.tailscaleAutoconnect.ephemeral = true;
}
