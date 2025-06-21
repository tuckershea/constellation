{
  config,
  ...
}:
{
  # not automatically created by services.actual??
  # should probably PR that.
  users.groups."actual" = {};
  users.users."actual" = {
    group = "actual";
    isSystemUser = true;
  };

  services.actual.enable = true;

  services.nginx.enable = true;
  services.nginx.virtualHosts."actual.constellation.tuckershea.com" = {
    useACMEHost = "actual.constellation.tuckershea.com";
    forceSSL = true;
    locations."/" = {
      proxyPass = let
          port = toString config.services.actual.settings.port;
        in "http://127.0.0.1:${port}";
      extraConfig = ''
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header Host $host;
      '';
    };
  };

  security.acme.certs."actual.constellation.tuckershea.com" = {
    domain = "actual.constellation.tuckershea.com";
    group = "nginx";
    dnsProvider = "cloudflare";
    # location of your CLOUDFLARE_DNS_API_TOKEN=[value]
    environmentFile = config.sops.secrets.cloudflare_dns_api_token.path;
    # nginx is automatically reloaded
  };

  environment.persistence."/persist".directories = [
    {
      directory = "/var/lib/private/actual";
      user = "actual";
      group = "actual";
      mode = "0700";
    }
  ];
}
