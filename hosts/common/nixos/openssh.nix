{
  lib,
  pkgs,
  ...
}:
{
  services.openssh.enable = true;
  # Hardening is configured in ./cis-hardening.nix
}
