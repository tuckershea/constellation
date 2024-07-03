# Elmira: personal mac laptop
{
  inputs,
  outputs,
  pkgs,
  ...
}: {
  imports = [
    ../common/core
    ../common/core-darwin

    ../common/optional/fonts.nix

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

  services.keep-hostname.enable = true;

  system.stateVersion = 4;
}
