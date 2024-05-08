# Elmira: personal mac laptop

{ inputs, outputs, pkgs, ... }:
{
  imports = [
    ../common/core
    ../common/core-darwin

    outputs.darwinModules.keep-hostname
    outputs.darwinModules.touchid

    ../common/users/tuckershea
  ];

  homebrew = {
    enable = true;
    onActivation.autoUpdate = true;
    casks = [
      "1password"
      "arc"
      "discord"
      "messenger"
      "rectangle"
      "slack"
      "keepingyouawake"
    ];
  };

  networking = {
    hostName = "elmira";
  };

  fonts.fontDir.enable = true;
  fonts.fonts = with pkgs; [
     recursive
     (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  services.keep-hostname.enable = true;

  system.stateVersion = 4;
}
