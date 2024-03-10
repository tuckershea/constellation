{ pkgs, lib, config, ... }:
{
  imports = [
    ./common/core

    ./common/optional/ssh/elmira.nix
  ];
}
