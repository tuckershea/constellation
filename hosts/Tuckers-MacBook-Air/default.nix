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

  # Hack to make pam-reattach work
  environment.etc."pam.d/sudo_local".text = ''
    # Written by nix-darwin
    auth       optional       ${pkgs.pam-reattach}/lib/pam/pam_reattach.so
    auth       sufficient     pam_tid.so
  '';
}
