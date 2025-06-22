{
  config,
  ...
}:
{
  services.nginx.enable = true;
  services.nginx.virtualHosts."auth.tuckershea.com" = {
    useACMEHost = "auth.tuckershea.com";
    forceSSL = true;

    locations."/" = {
      proxyPass = "https://auth-internal.constellation.tuckershea.com";
      extraConfig = ''
        proxy_ssl_name          $host;
        proxy_ssl_server_name   on;
      '';
    };
  };

  security.acme.certs."auth.tuckershea.com" = {
    domain = "auth.tuckershea.com";
    group = "nginx";
    dnsProvider = "cloudflare";
    # location of your CLOUDFLARE_DNS_API_TOKEN=[value]
    environmentFile = config.sops.secrets.cloudflare_dns_api_token.path;
    # nginx is automatically reloaded
  };
}
  