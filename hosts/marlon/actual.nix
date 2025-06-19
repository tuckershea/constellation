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

  services.actual = {
    enable = true;
    settings = {
      https = {
        key = "/var/lib/acme/actual.constellation.tuckershea.com/key.pem";
        cert = "/var/lib/acme/actual.constellation.tuckershea.com/cert.pem";
      };
      # Files are by default in the systemd StateDirectory
      # /var/lib/private/actual
    };
  };


  security.acme.certs."actual.constellation.tuckershea.com" = {
    domain = "actual.constellation.tuckershea.com";
    group = "actual";
    dnsProvider = "cloudflare";
    # location of your CLOUDFLARE_DNS_API_TOKEN=[value]
    environmentFile = config.sops.secrets.cloudflare_dns_api_token.path;
    reloadServices = [
      "actual.service"
    ];
  };

  environment.persistence."/persist" = {
    files = [  ];
    directories = [
      {
        directory = "/var/lib/private/actual";
        mode = "0700";
      }
    ];
  };
}
