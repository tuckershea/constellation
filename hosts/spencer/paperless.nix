{
  config,
  outputs,
  ...
}:
{
  # Celery build is broken in 25.11
  nixpkgs.overlays = [ outputs.overlays.celery ];

  services.paperless = {
    enable = true;
    settings = {
      PAPERLESS_CONSUMER_IGNORE_PATTERN = [
        ".DS_STORE/*"
        "desktop.ini"
      ];
      PAPERLESS_URL = "https://papers.constellation.tuckershea.com";
    };
  };

  services.nginx.enable = true;
  services.nginx.virtualHosts."papers.constellation.tuckershea.com" = {
    useACMEHost = "papers.constellation.tuckershea.com";
    forceSSL = true;
    locations."/" = {
      proxyPass = let
          port = toString config.services.paperless.port;
        in "http://127.0.0.1:${port}";
    };
  };

  security.acme.certs."papers.constellation.tuckershea.com" = {
    domain = "papers.constellation.tuckershea.com";
    group = "nginx";
    dnsProvider = "cloudflare";
    # location of your CLOUDFLARE_DNS_API_TOKEN=[value]
    environmentFile = config.sops.secrets.cloudflare_dns_api_token.path;
    # nginx is automatically reloaded
  };

  environment.persistence."/persist".directories = [
    {
      directory = config.services.paperless.dataDir;
      user = "paperless";
      group = "paperless";
      mode = "0700";
    }
  ];
}
