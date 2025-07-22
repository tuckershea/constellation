{
  pkgs,
  lib,
  ...
}: let
  inherit (pkgs) stdenv;
in {
  users.users.tuckershea =
    {
      home = lib.mkMerge [
        (lib.mkIf stdenv.isDarwin "/Users/tuckershea")
        (lib.mkIf stdenv.isLinux "/home/tuckershea")
      ];
      shell = pkgs.fish;
      description = "Tucker Shea";

      openssh.authorizedKeys.keyFiles = [
       ../../../../resources/publickeys/id_tuckershea_elmira.pub
      ];
    }
    // lib.optionalAttrs stdenv.isLinux {
      group = "tuckershea";
      isNormalUser = true;
      extraGroups = [ "wheel" "nixusers" "sshusers" ];
    };

  programs.fish.enable = true;  # configured in H-M

  users.groups.tuckershea = {};
}
