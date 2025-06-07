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

    ../common/users/tuckershea
  ];

  homebrew = {
    enable = true;
    onActivation.autoUpdate = true;
    # Needed since activation now runs as root.
    # Should revisit later to find a better system.
    user = "tuckershea";

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
      "double-commander"
      "inkscape"
      "itsycal"
      "keepingyouawake"
      "keycastr"
      "little-snitch"
      "lm-studio"
      "messenger"
      "netnewswire"
      "obs"
      "prismlauncher"
      "raycast"
      "rectangle"
      "skim"
      "slack"
      "swiftbar"
      "thunderbird"
      "zen-browser"
    ];
  };

  networking.computerName = "elmira";
  networking.hostName = "elmira.constellation.tuckershea.com";
  networking.localHostName = "elmira";

  services.keep-hostname.enable = true;
  services.krb5renew.enable = true;

  security.pam.services.sudo_local = {
    enable = true;
    reattach = true;
    touchIdAuth = true;
    watchIdAuth = true;
  };

  system.stateVersion = 4;
}
