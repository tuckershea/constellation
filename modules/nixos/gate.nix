{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.services.gate;
  settingsFormat = pkgs.formats.yaml { };
  configFile = settingsFormat.generate "config.yaml" cfg.settings;
in {
  options = {
    services.gate.enable = mkEnableOption "Whether to enable the gate server.";

    services.gate.package = mkOption {
      type = types.package;
      default = pkgs.gate;
      description = "The gate package to use.";
    };

    services.gate.settings = mkOption {
      type = settingsFormat.type;
      description = "A file with YAML configuration for gate.";
    };
  };

  config = mkIf cfg.enable {
    # FIXME hardcoded
    # it's just annoying to extract this from the bind string
    networking.firewall.allowedTCPPorts = [25565];
    
    systemd.services.gate = {
      after = ["network-pre.target"];
      wants = ["network-pre.target"];
      wantedBy = ["multi-user.target"];

      serviceConfig.Type = "exec";
      script = "${cfg.package}/bin/gate --config ${configFile}";
    };
  };
}
