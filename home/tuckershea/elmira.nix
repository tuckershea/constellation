{ pkgs, lib, config, ... }:
{
  imports = [
    ./common/core
    ./common/core-darwin

    ./common/optional/ssh/elmira.nix
  ];
}
