{ lib, ... }:
{
  programs.ssh = {
    enable = true;
    serverAliveInterval = 30;

    matchBlocks = {
      "*" = {
        identityFile = [ "~/.ssh/id_elmira_tuckershea.pub" ];
        extraOptions = {
          # Use 1password for auth on elmira (darwin)
          IdentityAgent = "\"~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock\"";
        };
      };

      famat = lib.hm.dag.entryBefore ["*"] {
        hostname = "ssh.pythonanywhere.com";
        user = "famat";
        identityFile = [ "~/.ssh/id_pythonanywhere_famat.pub" ];
        identitiesOnly = true;
      };
      andrew = lib.hm.dag.entryBefore ["*"] {
        hostname = "unix.andrew.cmu.edu";
        user = "tshea";
      };
    };
  };

  home.file.".ssh/.keep".text = "Managed by home-manager";
  home.file.".ssh/id_elmira_tuckershea.pub".source = ../../../../../resources/publickeys/id_elmira_tuckershea.pub;
  home.file.".ssh/id_pythonanywhere_famat.pub".source = ../../../../../resources/publickeys/id_pythonanywhere_famat.pub;
}
