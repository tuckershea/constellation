{
  sops.secrets.tailscale_key.sopsFile = ./host_secrets.+marlon.yaml;
  sops.secrets.terraria_password.sopsFile = ./host_secrets.+marlon.yaml;

  sops.secrets.tuckershea_age_key = {
    sopsFile = ./tuckershea_age_key.txt.+marlon.enc;
    format = "binary";
    owner = "tuckershea";
    group = "tuckershea";
    path = "/home/tuckershea/.age-key.txt";
  };
}

