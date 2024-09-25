# Restore configured hostname
#
# Simple daemon to refresh my Kerberos tickets.
# In the long term this should probably be replaced
# by k5start or similar.
{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.services.krb5renew;
in {
  options.services.krb5renew = {
    enable = mkEnableOption "krb5renew";
  };

  config = mkIf cfg.enable {
    launchd.daemons.tuckershea-krb5renew = {
      serviceConfig = {
        Label = "org.tuckershea.krb5renew";
        StartInterval = 5 * 60; # every 5 minutes
      };

      command = "kinit -R -c FILE:/Users/tuckershea/krb5-ccache";
    };
  };
}
