{
  outputs,
  config,
  ...
}:
{
  imports = [outputs.nixosModules.mailrise];

  sops.secrets.mailriseConfig = {
    format = "binary";
    sopsFile = ./mailrise.yaml.+spencer.enc;
  };

  services.mailrise = {
    enable = true;
    configFile = config.sops.secrets.mailriseConfig.path;
  };
}
