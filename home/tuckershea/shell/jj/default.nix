{
  lib,
  pkgs,
  ...
}:
{
  programs.jujutsu = {
    enable = true;
    settings = (builtins.fromTOML (builtins.readFile ./config.toml));
  };
}
