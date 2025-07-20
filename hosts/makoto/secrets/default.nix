{
  sops.secrets.tuckershea_age_key = {
    sopsFile = ./tuckershea_age_key.txt.+makoto.enc;
    format = "binary";
    owner = "tuckershea";
    group = "tuckershea";
    path = "/home/tuckershea/.age-key.txt";
  };
}

