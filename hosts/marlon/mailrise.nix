{
  outputs,
  config,
  ...
}:
{
  imports = [outputs.nixosModules.mailrise];

  sops.secrets.mailriseConfig = {
    format = "binary";
    sopsFile = ./mailrise.yaml.enc;
  };

  services.mailrise = {
    enable = true;
    configFile = config.sops.secrets.mailriseConfig.path;
  };
}
