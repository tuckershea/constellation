{ config, inputs, lib, ... }: {
  programs.ssh = {
    enable = true;
    serverAliveInterval = 30;

    includes = [
      "./config.d/*"
    ];

    matchBlocks = {
      "*" = {
        identityFile = ["~/.ssh/id_tuckershea_elmira.pub"];
        extraOptions = {
          # Use 1password for auth on elmira (darwin)
          IdentityAgent = "\"~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock\"";
        };
      };
    };
  };

  home.file.".ssh/.keep".text = "Managed by home-manager";
  home.file.".ssh/id_tuckershea_elmira.pub".source = ../../../../resources/publickeys/id_tuckershea_elmira.pub;
}
