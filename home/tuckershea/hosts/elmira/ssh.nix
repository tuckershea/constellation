{lib, ...}: {
  programs.ssh = {
    enable = true;
    serverAliveInterval = 30;

    matchBlocks = {
      "*" = {
        identityFile = ["~/.ssh/id_tuckershea_elmira.pub"];
        extraOptions = {
          # Use 1password for auth on elmira (darwin)
          IdentityAgent = "\"~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock\"";
        };
      };

      famat = lib.hm.dag.entryBefore ["*"] {
        hostname = "ssh.pythonanywhere.com";
        user = "famat";
        identitiesOnly = true;
      };
      andrew = lib.hm.dag.entryBefore ["*"] {
        hostname = "unix.andrew.cmu.edu";
        user = "tshea";
      };
    };

    extraConfig = lib.mkMerge [
        "GSSAPIAuthentication yes"
        "GSSAPIDelegateCredentials yes"
    ];
  };

  home.file.".ssh/.keep".text = "Managed by home-manager";
  home.file.".ssh/id_tuckershea_elmira.pub".source = ../../../../resources/publickeys/id_tuckershea_elmira.pub;
}
