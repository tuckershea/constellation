# Restore configured hostname
#
# Occasionally on some networks, MacOS detects its own hostname
# as a duplicate and reconfigures itself as hostname-2 (or -3, etc).
# We'd like to keep our original hostname, so this service
# sets it back on a regular interval.
{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.services.keep-hostname;
in {
  options.services.keep-hostname = {
    enable = mkEnableOption "keep-hostname";
  };

  config = mkIf cfg.enable {
    assertions = [
      {
        assertion = config.networking.hostName != null;
        message = "networking.hostName must be set";
      }
    ];

    launchd.daemons.keep-hostname = {
      # "Restore hostname when it glitches to hostname-2";

      serviceConfig = {
        Label = "org.tuckershea.keep-hostname";

        StartInterval = 5 * 60; # every 5 minutes
      };

      script = ''
        scutil --set LocalHostName ${config.networking.hostName}
        scutil --set HostName ${config.networking.hostName}
      '';
    };
  };
}
