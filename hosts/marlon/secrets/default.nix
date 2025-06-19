{
  sops.secrets.terraria_password.sopsFile = ./host_secrets.+marlon.yaml;

  sops.secrets.tuckershea_age_key = {
    sopsFile = ./tuckershea_age_key.txt.+marlon.enc;
    format = "binary";
    owner = "tuckershea";
    group = "tuckershea";
    path = "/home/tuckershea/.age-key.txt";
  };

  sops.secrets.cloudflare_dns_api_token = {
    sopsFile = ./cloudflare_dns_api_token.env.+marlon.enc;
    format = "binary";
    owner = "tuckershea";
    group = "tuckershea";
  };
}

