# Elmira: personal mac laptop

{ inputs, pkgs, ... }:
{
  imports = [
    ../common/core

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

  security.pam.enableSudoTouchIdAuth = true;

  # Hack to make pam-reattach work
  environment.etc."pam.d/sudo_local".text = ''
    # Written by nix-darwin
    auth       optional       ${pkgs.pam-reattach}/lib/pam/pam_reattach.so
    auth       sufficient     pam_tid.so
  '';

  system.stateVersion = 4;
}
