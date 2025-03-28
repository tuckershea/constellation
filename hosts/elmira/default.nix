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
    outputs.darwinModules.krb5renew
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
      "alt-tab"
      "arc"
      "betterdisplay"
      "bettertouchtool"
      "discord"
      "inkscape"
      "itsycal"
      "keepingyouawake"
      "keycastr"
      "little-snitch"
      "lm-studio"
      "messenger"
      "obs"
      "prismlauncher"
      "raycast"
      "rectangle"
      "skim"
      "slack"
      "swiftbar"
      "zen-browser"
    ];
  };

  networking.computerName = "elmira";
  networking.hostName = "elmira.constellation.tuckershea.com";
  networking.localHostName = "elmira";

  services.keep-hostname.enable = true;
  services.krb5renew.enable = true;

  system.stateVersion = 4;
}
