{
  config,
  ...
}:
{
  # Needs to be accessible to both keycloak and postgres?
  sops.secrets.keycloak_database_password = {
    sopsFile = ./keycloak_database_password.txt.+spencer.enc;
    format = "binary";
#    owner = "keycloak";
#    group = "postgres";
  };

  services.keycloak = {
    enable = true;
    initialAdminPassword = "admin";
    settings = {
      hostname = "https://auth.tuckershea.com";
      hostname-backchannel-dynamic = true;
      hostname-admin = "https://auth-admin.constellation.tuckershea.com";
      http-port = 38080;
      #https-port = 38443;
      http-enabled = true;
      proxy-headers = "xforwarded";
      proxy-trusted-addresses = "127.0.0.0/8";
    };
    database.passwordFile = config.sops.secrets.keycloak_database_password.path;
  };

  # Also see: marlon keycloak

  services.nginx.enable = true;
  services.nginx.virtualHosts."auth.tuckershea.com" = {
    # HOST header is auth.tuckershea.com
    # but accessed via auth-internal...
    # maybe there's a better way to architect this
    useACMEHost = "auth-internal.constellation.tuckershea.com";
    forceSSL = true;
    locations."/" = {
      proxyPass = let
          port = toString config.services.keycloak.settings.http-port;
        in "http://127.0.0.1:${port}";
    };
  };
  services.nginx.virtualHosts."auth-admin.constellation.tuckershea.com" = {
    useACMEHost = "auth-admin.constellation.tuckershea.com";
    forceSSL = true;
    locations."/" = {
      proxyPass = let
          port = toString config.services.keycloak.settings.http-port;
        in "http://127.0.0.1:${port}";
    };
  };

  security.acme.certs."auth-internal.constellation.tuckershea.com" = {
    domain = "auth-internal.constellation.tuckershea.com";
    group = "nginx";
    dnsProvider = "cloudflare";
    # location of your CLOUDFLARE_DNS_API_TOKEN=[value]
    environmentFile = config.sops.secrets.cloudflare_dns_api_token.path;
    # nginx is automatically reloaded
  };
  security.acme.certs."auth-admin.constellation.tuckershea.com" = {
    domain = "auth-admin.constellation.tuckershea.com";
    group = "nginx";
    dnsProvider = "cloudflare";
    # location of your CLOUDFLARE_DNS_API_TOKEN=[value]
    environmentFile = config.sops.secrets.cloudflare_dns_api_token.path;
    # nginx is automatically reloaded
  };

  # TODO: persistence once I get some experience with this
}
