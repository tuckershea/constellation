{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.services.mailrise;
in {
  options.services.mailrise = {
    enable = mkEnableOption "Whether to enable the mailrise server.";

    package = mkOption {
      type = types.package;
      default = pkgs.callPackage ../../pkgs/mailrise.nix {};
      description = "The mailrise package to use.";
    };

    envFile = mkOption {
      type = types.path;
      description = "Environment variables for mailrise. Useful for secret URLs.";
    };

    configFile = mkOption {
      type = types.path;
      description = "YAML configuration for mailrise.";
    };
  };

  config = mkIf cfg.enable {
    systemd.services.mailrise = {
      after = ["network-pre.target"];
      wants = ["network-pre.target"];
      wantedBy = ["multi-user.target"];

      serviceConfig.Type = "exec";
      script = ''
        set -o allexport
        source ${cfg.envFile}
        set +o allexport
        ${cfg.package}/bin/mailrise ${cfg.configFile}
      '';
    };
  };
}
