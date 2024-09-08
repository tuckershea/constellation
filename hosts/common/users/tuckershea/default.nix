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
    shell = pkgs.zsh;
    description = "Tucker Shea";

    openssh.authorizedKeys.keyFiles = [
      ../../../../resources/publickeys/id_tuckershea_elmira.pub
    ];

    group = lib.mkIf stdenv.isLinux "tuckershea";
    isNormalUser = lib.mkIf stdenv.isLinux true;
    extraGroups = lib.mkIf stdenv.isLinux ["wheel"];
  };

  users.groups.tuckershea = lib.mkIf stdenv.isLinux {};
}
