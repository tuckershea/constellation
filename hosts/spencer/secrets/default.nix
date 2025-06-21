{
  sops.secrets.tuckershea_age_key = {
    sopsFile = ./tuckershea_age_key.txt.+spencer.enc;
    format = "binary";
    owner = "tuckershea";
    group = "tuckershea";
    path = "/home/tuckershea/.age-key.txt";
  };

  sops.secrets.cloudflare_dns_api_token = {
    sopsFile = ./cloudflare_dns_api_token.env.+spencer.enc;
    format = "binary";
    owner = "tuckershea";
    group = "tuckershea";
  };
}

