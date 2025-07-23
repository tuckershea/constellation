{
  outputs,
  config,
  ...
}:
{
  imports = [outputs.nixosModules.mailrise];

  sops.secrets.mailriseEnv = {
    format = "binary";
    sopsFile = ./mailrise.env.+spencer.enc;
  };

  services.mailrise = {
    enable = true;
    configFile = ./mailrise.yaml;
    envFile = config.sops.secrets.mailriseEnv.path;
  };
}
