{
  config,
  lib,
  pkgs,
  ...
}:
{
  services.clamav = {
    daemon.enable = true;
    scanner.enable = true;
    updater.enable = true;
  };
}
