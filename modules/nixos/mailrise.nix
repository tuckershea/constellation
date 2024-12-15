{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.services.mailrise;
in {
  options = {
    services.mailrise.enable = mkEnableOption "Whether to enable the mailrise server.";

    services.mailrise.package = mkOption {
      type = types.package;
      default = pkgs.callPackage ../../pkgs/mailrise.nix {};
      description = "The mailrise package to use.";
    };

    services.mailrise.configFile = mkOption {
      type = types.path;
      description = "A file with YAML configuration for mailrise. Consider that this file may contain secrets.";
    };
  };

  config = mkIf cfg.enable {
    systemd.services.mailrise = {
      after = ["network-pre.target"];
      wants = ["network-pre.target"];
      wantedBy = ["multi-user.target"];

      serviceConfig.Type = "exec";
      script = "${cfg.package}/bin/mailrise ${cfg.configFile}";
    };
  };
}
