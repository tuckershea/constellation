# Elmira: personal mac laptop
{
  inputs,
  outputs,
  pkgs,
  ...
}: {
  imports = [
    ../common/core
    ../common/darwin
    ../common/graphical

    # optionals here...

    outputs.darwinModules.keep-hostname
    outputs.darwinModules.touchid

    ../common/users/tuckershea
  ];

  homebrew = {
    enable = true;
    onActivation.autoUpdate = true;

    brews = [
      "kstart"
    ];
    casks = [
      "1password"
      "arc"
      "discord"
      "keepingyouawake"
      "keycastr"
      "messenger"
      "rectangle"
      "slack"
    ];
  };

  networking = {
    hostName = "elmira";
  };

  services.keep-hostname.enable = true;

  system.stateVersion = 4;
}
