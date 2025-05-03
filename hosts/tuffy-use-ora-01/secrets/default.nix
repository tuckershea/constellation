{
  sops.secrets.tuckershea_age_key = {
    sopsFile = ./tuckershea_age_key.txt.+tuffy-use-ora-01.enc;
    format = "binary";
    owner = "tuckershea";
    group = "tuckershea";
    path = "/home/tuckershea/.age-key.txt";
  };
}
