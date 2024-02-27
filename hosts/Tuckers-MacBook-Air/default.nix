{ pkgs, ... }:
{
  system.stateVersion = 4;

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

  users.users.tuckershea.home = "/Users/tuckershea";
}
