{lib, ...}:
{
  programs.ssh = {
    enable = true;
    serverAliveInterval = 30;

    matchBlocks = {
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
}
