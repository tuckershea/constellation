{ ... }:
{
  environment.persistence."/big-persist" = {
    directories = [
      {
        directory = "/srv/minecraft";
        user = "minecraft";
        group = "minecraft";
        mode = "0700";
      }
    ];
  };

  services.minecraft-servers.enable = true;
  services.minecraft-servers.eula = true;
  services.minecraft-servers.servers.palm = {
    enable = true;
    package = pkgs.paperServers.paper-1_21_4;
    openFirewall = true;
    enableReload = true;

    whitelist = {
      tuckoyaki = "887cc0a9-2e8f-41f0-b96b-115a02a8ab66";
      varblank = "af569a3a-8615-4046-bb84-5f5af5ff8cd7";
    };

    serverProperties = {
      server-port = 25565;
      difficulty = 1;
      gamemode = 0;
      max-players = 5;
      motd = "Haiii";
      white-list = true;
      allow-cheats = false;
      view-distance = 24;
    };

    jvmOpts = "-Xms2G -Xmx16G";
  };
}
