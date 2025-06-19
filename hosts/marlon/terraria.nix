{ config, lib, pkgs, ... }:
{
#   virtualisation.oci-containers.containers.terraria = 
#   let
#     terrariaDockerHub = pkgs.dockerTools.pullImage {
#       imageName = "ryshe/terraria";
#       imageDigest =  # tshock-1.4.4.9-5.2.0-3
#         "sha256:804c42fbe9cbcff0b22c46b120a165ba22b482298e7898ec81803124676d3a0b";
#       sha256 = "sha256-gJ3T+vmEsfIHkA+fUcYZfZnWg0zm9YukCti0fTTLXXA=";
#     };
#   in {
#     hostname = "terraria";
#     image = "ryshe/terraria";
#     imageFile = terrariaDockerHub;
#     ports = [ "7777:7777" ];
#     volumes = [ "/srv/terraria/worlds:/root/.local/share/Terraria/Worlds" ];
#     environment = {
#       WORLD_FILENAME = "World.wld";
#     };
#   };

  environment.persistence."/persist" = {
    directories = [
      "/srv/terraria"
    ];
  };
}
