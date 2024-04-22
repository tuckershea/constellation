{ pkgs, ... }:
{
  virtualisation.docker.enable = true;

  # Patch docker container networking
  # by giving them a specific DNS target.
  # Weirdly enough, it seems to work correctly
  # with tailscale routing (e.g. accessing marlon:9090),
  # but I should make sure that it keeps working.
#  virtualisation.docker.daemon.settings = {
#    dns = [ "8.8.8.8" ];
#  };

  users.users.tuckershea.extraGroups = [ "docker" ];

  networking.firewall.trustedInterfaces = [ "docker0" ];
}
