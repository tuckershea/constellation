{
  programs.git = {
    enable = true;
    delta.enable = true;
    hooks = {
      # pre-commit = ./../pre-commit-script;
    };
    ignores = [
      "*.swp"
      ".DS_Store"
      "._.DS_Store"
      "**/.DS_Store"
      "**/._.DS_Store"
    ];
    signing = {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMh3wNTGjXPzrHWZI1ZZfoRg3w6osDeB1VUYSaRd5Dk9";
      signByDefault = true;
    };
    userEmail = "tucker@tuckershea.com";
    userName = "NoRePercussions";
    extraConfig = {
      gpg.format = "ssh";
      core.autocrlf = "input";
      init.defaultBranch = "main";

      # todo: change this for non-mac systems
      "gpg \"ssh\"".program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
    };
  };
}
