{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.services.kanata;
in {
  options = {
    services.kanata.enable = mkOption {
      type = types.bool;
      default = false;
      description = "Whether to enable the kanata remapping daemon.";
    };

    services.kanata.package = mkOption {
      type = types.package;
      default = pkgs.callPackage ../../pkgs/kanata-darwin.nix {};
      description = "The kanata package to use.";
    };

    services.kanata.config = mkOption {
      type = types.lines;
      default = "";
#      example = "alt + shift - r   :   chunkc quit";
      description = "Config to kanata.";
    };
  };

  config = mkIf cfg.enable {
    assertions =
    [ { assertion = (cfg.config != "");
        message = "No Kanata configuration passed at config.services.kanata.config";
      }
    ];

    launchd.daemons.kanata = 
    let
      config_file = pkgs.writeTextFile {
        name = "kanata.kbd";
        text = cfg.config;
      };
    in {
      path = [config.environment.systemPath];

      serviceConfig.ProgramArguments =
        ["${cfg.package}/bin/kanata" "--cfg" "${config_file}"];
      serviceConfig.KeepAlive = true;
      serviceConfig.ProcessType = "Interactive";
    };
  };
}
