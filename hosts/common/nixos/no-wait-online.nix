# Patches a bug where upgrading nixos causing Wait-Online to fail
# by just disabling it. I can't find anything that it breaks.
{pkgs, ...}: {
  systemd.services.NetworkManager-wait-online.enable = pkgs.lib.mkForce false;
}
