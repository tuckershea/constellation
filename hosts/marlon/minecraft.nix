{ ... }:
{
  services.minecraft-server = {
    enable = true;
    eula = true;
    openFirewall = true;
    declarative = true;
    whitelist = {
      # This is a mapping from Minecraft usernames to UUIDs. You can use https://mcuuid.net/ to get a Minecraft UUID for a username
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
    };
    jvmOpts = "-Xms2048M -Xmx4092M";
  };

  environment.persistence."/persist" = {
    directories = [
      {
        directory = "/var/lib/minecraft";
        user = "minecraft";
        group = "minecraft";
        mode = "0700";
      }
    ];
  };
}
