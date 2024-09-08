{
  lib,
  pkgs,
  ...
}: {
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
      key = lib.removeSuffix "\n" (builtins.readFile ../../../resources/publickeys/id_norepercussions_github.pub);
      signByDefault = true;
    };
    userEmail = "tucker@tuckershea.com";
    userName = "NoRePercussions";
    extraConfig = {
      gpg.format = "ssh";
      core.autocrlf = "input";
      init.defaultBranch = "main";

      "gpg \"ssh\"".program = lib.mkIf pkgs.stdenv.isDarwin "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
    };
  };
}
