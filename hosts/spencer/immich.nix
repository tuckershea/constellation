{
  config,
  ...
}:
{
  services.immich= {
    enable = true;
  };

  services.nginx.enable = true;
  services.nginx.virtualHosts."photos.constellation.tuckershea.com" = {
    useACMEHost = "photos.constellation.tuckershea.com";
    forceSSL = true;
    locations."/" = {
      proxyPass = let
          port = toString config.services.immich.port;
        # must be localhost, not 127.0.0.1
        in "http://localhost:${port}";
      proxyWebsockets = true;
      extraConfig = ''
        client_max_body_size 50000M;
        proxy_read_timeout   600s;
        proxy_send_timeout   600s;
        send_timeout         600s;
      '';
    };
  };

  security.acme.certs."photos.constellation.tuckershea.com" = {
    domain = "photos.constellation.tuckershea.com";
    group = "nginx";
    dnsProvider = "cloudflare";
    # location of your CLOUDFLARE_DNS_API_TOKEN=[value]
    environmentFile = config.sops.secrets.cloudflare_dns_api_token.path;
    # nginx is automatically reloaded
  };

  environment.persistence."/persist".directories = [
    {
      directory = config.services.immich.mediaLocation;
      user = config.services.immich.user;
      group = config.services.immich.group;
      mode = "0700";
    }
  ];
}
