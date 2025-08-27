{
  lib,
  pkgs,
  ...
}: {
  programs.git = {
    enable = true;
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
    settings = {
      user = {
        email = "tucker@tuckershea.com";
        name = "NoRePercussions";
      };
      gpg.format = "ssh";
      core.autocrlf = "input";
      init.defaultBranch = "main";
    };
  };

  programs.delta.enable = true;
  programs.delta.enableGitIntegration = true;
}
