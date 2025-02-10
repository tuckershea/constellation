{
  config,
  ...
}:
{
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      key_path = config.sops.secrets.atuin_key.path;
    };
  };

  sops.secrets.atuin_key = {
    sopsFile = ./atuin_key.+tuckershea.enc;
    format = "binary";
  };
}

