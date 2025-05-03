{
  ...
}:
{
  sops.secrets.tailscale_authkey = {
    sopsFile = ./authkey.+vic.enc;
    format = "binary";
  };
}
