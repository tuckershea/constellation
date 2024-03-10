{ pkgs, lib, ... }:
let
  inherit (pkgs) stdenv;
in
{
  users.users.tuckershea = {
    home = if stdenv.isDarwin then "/Users/tuckershea" else "/home/tuckershea";
    shell = pkgs.zsh;
    
    openssh.authorizedKeys.keyFiles = [
      ../../../../resources/publickeys/id_elmira_tuckershea.pub
    ];

    packages = [  ];
  } // lib.optionalAttrs stdenv.isLinux {
    group = "tuckershea";
    isNormalUser = true;
  };

  users.groups.tuckershea = { };
}

