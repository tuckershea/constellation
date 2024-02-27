{ config, pkgs, lib, ... }:
{
  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    coreutils
    curl
    wget
  ] ++ lib.optionals stdenv.isDarwin [
  
  ];

  home.shellAliases = {
    ".." = "cd ..";
    "~" = "cd ~";
  };

  # e.g. programs.tmux
}
