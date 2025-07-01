{
  pkgs,
  inputs,
  outputs,
  ...
}:
{
  imports = [
    outputs.nixosModules.gate
  ];
  
  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];

  environment.persistence."/persist" = {
    directories = [
      {
        directory = "/srv/minecraft";
        user = "minecraft";
        group = "minecraft";
        mode = "0700";
      }
    ];
  };
  environment.persistence."/big-persist" = {
    directories = [
      {
        directory = "/srv/www/mc.abte.ch";
        user = "minecraft";
        group = "nginx";
        mode = "2750";
      }
    ];
  };

  services.gate = {
    enable = true;
    settings.config = {
      bind = "0.0.0.0:25565";
      #onlineMode = true;
      #status.motd = "hello world";
      #status.logPingRequests = true;
      lite = {
        enabled = true;
        routes = [
          {
            host = ["mc.abte.ch" "abtechminecraft.games.tuckershea.com"];
            backend = "localhost:25566";
            fallback.motd = "no";
          }
        ];
      };
    };
  };

  services.nginx.enable = true;
  networking.firewall.allowedTCPPorts = [ 80 443 ];
  services.nginx.virtualHosts."mc.abte.ch" = {
    enableACME = true;
    forceSSL = true;
    locations."/" = {
      root = "/srv/www/mc.abte.ch";
      extraConfig = ''
        expires 0;
        add_header Cache-Control private;
      '';
    };
  };

  # Uncomment to log errors to journalctl rather than letting
  # them vanish into the tmux void on crash
  #services.minecraft-servers.managementSystem.tmux.enable = false;
  #services.minecraft-servers.managementSystem.systemd-socket.enable = true;
  
  services.minecraft-servers.enable = true;
  services.minecraft-servers.eula = true;
  services.minecraft-servers.servers.abtechminecraft = {
    enable = true;
    package = pkgs.fabricServers.fabric-1_21_5;
    path = [ pkgs.sqlite ];
    openFirewall = false;
    enableReload = true;

    serverProperties = {
      server-port = 25566;
      motd = "🐻 fly by night sound and light";

      max-players = 25;
      # White list is managed by commands,
      # so I need to enable it but not specify
      # players to whitelist.
      white-list = true;

      level-seed = "2430";

      difficulty = 1;
      gamemode = 0;
      allow-cheats = false;
      # manually set keepinventory

      view-distance = 10;
      max-world-size = 10000;

      pause-when-empty-seconds = -1;  # keep dynmap going
    };

    jvmOpts = "-Xms4G -Xmx20G";

    symlinks = {
      "dynmap/configuration.txt" = ./dynmap_configuration.txt;

      mods = pkgs.linkFarmFromDrvs "mods" (
        builtins.attrValues {
          Distant-Horizons = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/uCdwusMi/versions/Mt9bDAs6/DistantHorizons-neoforge-fabric-2.3.2-b-1.21.5.jar"; sha512 = "e17d845f5ddb71a9ca644875a02b845e045bb5c7e72429e120271636936a816b416bb4ba13789de18c3af6a1a5f5b7ed5dbe07326c60d5c49534a382310dab1f"; };

          Dynmap = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/fRQREgAc/versions/sXDq1ybz/Dynmap-3.7-beta-9-fabric-1.21.5.jar"; sha512 = "811fab928cf61544b982f5b530c5bbd22dbc55560e813d07bf070a9368dc57cfaea57c70709bce88b80dba825545a1bee282ddd6e669def04d237a214c556751"; };

          # girlfiend-approved terrain generation
          Terralith = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/8oi3bsk5/versions/D7rFyTAc/Terralith_1.21.x_v2.5.10.jar"; sha512 = "3c3841f634e6fe0221c94d5d6f792d4d051a50d912ec90e76f689d9a7f0e1137d11d8fac0d6cd3f5af140ba82a285d739c769cb4fa7fc2b60e256cd9d0b01cdc"; };
          Tectonic = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/lWDHr9jE/versions/96BO8leD/tectonic-3.0.1-fabric-1.21.5.jar"; sha512 = "26ce93c798bce5a98a84fc427189430104be2f6761d1421ffd8f014cdc8c6d8867f3764f08c3d738def91231ebc212d405300ec088fbfe6dff796a25f7829f78"; };
          Lithostitched = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/XaDC71GB/versions/wupt6y4U/lithostitched-fabric-1.21.5-1.4.8.jar"; sha512 = "bfc7d3309cf6c26ed20b556380be2c84d6103c5d92484255fb9a44f3409830a5cec4f958cfd758c16357c3f1b022356f4d5947d461eaf2c0a3805521ed073b4a"; };
          Dungeons-and-Taverns = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/tpehi7ww/versions/upyHsGeL/dungeons-and-taverns-v4.7.3.jar"; sha512 = "82c7df7627cf864a5a1cec271e9cd5a5d416f7c7b542fafeea37fdd55d171c0ba1f690bd8f6a90c1ae03cdc4fac0cdef11d01217e8adb25d12064263b11690d4"; };

          Chunky = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/fALzjamp/versions/mhLtMoLk/Chunky-Fabric-1.4.36.jar"; sha512 = "65a201c246c95f6189a16e715d944e4a7ca7f44a8c4a39c8e6523d8c58e331d6611c78deff050cb4a2a2d80c5b8d84e3593a9b8ff961f7aee3d171a4ef7af2c7"; };

          # quality-of-life
          Styled-Nicknames = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/DOk6Gcdi/versions/HCbWj9Bk/styled-nicknames-1.8.0%2B1.21.5.jar"; sha512 = "21fc2d0fcf6c6680909d3cc0ff7e53fda7c33d60b7d4ae042db9ccd59fd1bc40049bd9489920176122e7f07636e12acff3b00e25c1af8145e262d48f6ded925c"; };
          BlossomHomes = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/FXeppAS4/versions/3K3h6Bpc/blossom-homes-2.2.9%2B1.21.5.jar"; sha512 = "6f3cf7579eb87745f3d51f8a4e96d40f6636c0db21cb05129ba394255bf4ca3d59a08d0441a9af14129daac89b785b0bf3d835c1dcd14a3094995440f1b2e84f"; };
          BlossomTpa = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/Y25EUH1s/versions/ukRrxnXI/blossom-tpa-2.2.9%2B1.21.3.jar"; sha512 = "6c7ef74962898f5f99c3f4a9d1bb3bc81af9fd3894df370142da1a7401a0bc8efd5094569d19c6a1c2ac8955cd089ff7f38c14e3e9d25b371000533c6f7649a4"; };
          BlossomLib = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/Xw7lTsbM/versions/SgIlV2Rc/blossom-lib-2.5.14%2B1.21.5.jar"; sha512 = "3bf6e041da729d9172d67eee7485310774ba9a7272cddf4fe86256260d3c1af65c8bfd9c362637a19c59f079fd4360f38d4a358d82f7e994008d0948827e9758"; };

          Do-a-Barrel-Roll = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/6FtRfnLg/versions/V0e6gDT5/do_a_barrel_roll-fabric-3.8.1%2B1.21.5.jar"; sha512 = "47ef2e80b72ac566f54d6b35a90f166cdd360deabff9e93aa2a2fc9b31824b198efcf99d0d0a17a254455646bfb80b6422bc33a559a85a7721549d7ea760834d"; };
          CICADA = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/IwCkru1D/versions/2LuLtZUC/cicada-lib-0.13.1%2B1.21.5-and-above.jar"; sha512 = "00be5317c4ddae59be859a4d794cce58c425f9418651370a9dc425570bb316f15422e9ae78c2bf0ce8e39aad4a972a39b78f8c4cd8bcd7ac15f95bb51f709a5e"; };
          YACL = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/1eAoo2KR/versions/Fp5lATXW/yet_another_config_lib_v3-3.7.1%2B1.21.5-fabric.jar"; sha512 = "30282d2a9fe2eb4b4061c863100778f81ef68194dcd3785e75d0ad7ccdf0783e29d6d9bfe2b6a82c17f6fd94eb0c6a82e3989633cc6f66c2190f0bd031bea624"; };
          Double-Doors = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/JrvR9OHr/versions/1gYbfoqD/doubledoors-1.21.5-7.0.jar"; sha512 = "1640722969e1d6ed9474cb968381359ee9e7a61509a730f4c2cf75d84069fe3afe7ef2d306459a0597f4453dac22dd2d4414ec618642600cddeeb263f8b98d88"; };
          Collective = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/e0M1UDsY/versions/aCWSF57s/collective-1.21.5-8.3.jar"; sha512 = "bf47502d20e03c2fd5964e4799d7988334358ffe26cbb9b9414d453d771a19938e13dcc0989f5b1c0c5e965f35a9f480c95cf0849818c6433f470771c4c5229e"; };
          Crops-Love-Rain = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/cRci7UZp/versions/cOzf5FGy/Crops-Love-Rain-2.4.2.jar"; sha512 = "0a334c30ef11bc126ae6dc58225a81b00d5f4e6cdbb0d4242e6929935b6eb65d5a9a7ddef435d05b0b691d1beba74f0cfbad6c63ec79e8518f4fcb3455fc8aa8"; };
          Boids = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/2OckSy74/versions/aiZEd0aD/Boids-1.2.3.jar"; sha512 = "cc4bb075fe7b6263ea16d0c6deaa0ec3ae98d46861f50444406cc3ca9e1cc5a069833bc86007086217240a7cf8664e45bcc99fd4bebc1f5acf7093aaa15922c2"; };
          Easy-Elytra-Takeoff = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/3hqwGCUB/versions/3dwFGkOm/easyelytratakeoff-1.21.5-4.5.jar"; sha512 = "14da27c2d273bf537c26fc6c7a39d1fdfd67dcab21736b5a0760c9aacee434e299c7bae89c394ad42876ddde9bed757380573f8d1753d1cedff56a1c92849364"; };

          # modlist pretty much ripped from Simply Optimized
          BadOptimizations = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/g96Z4WVZ/versions/VLDb95oX/BadOptimizations-2.2.3-1.21.2-21.6.jar"; sha512 = "3cab72f026d9058380c3c71c71eb8bc0b2c1a7cbcbaf6d95ac65f6177b9f02de507510fe05633824da50b1143778ddf9bb2b4170f11c2f0f4eb96018ef3e1aa8"; };
          Cloth-Config-API = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/9s6osm5g/versions/qA00xo1O/cloth-config-18.0.145-fabric.jar"; sha512 = "2752215fdc303598f0e98208a3ddae404c413aa3de22f5e2db2f2cc2c7813f08a1731da6778a6b9056a6ebe3b74919fce67abd14332269ad0a353bdc6e9e92c4"; };
          Concurrent-Chunk-Management-Engine = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/VSNURh3q/versions/jrmtD6AF/c2me-fabric-mc1.21.5-0.3.3.0.0.jar"; sha512 = "4d6a3efcef9aaec8b494f1ac5917c5230175d6485592243a45eb2ee263baf481ce07681b0fb5b65a4969cd08d4708e001a83b17949dad32a646a8ea26052a9f9"; };
          # TODO: enhanced block entities
          Entity-Culling = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/NNAgCjsB/versions/2BwJZLax/entityculling-fabric-1.8.0-mc1.21.5.jar"; sha512 = "0dacc5cd4bcc349373cfff96123169ff53a4056cfb05e79011c22f871d30284c3eaebdfd681dfc49f71acdbb437d0da26352b4421fde6560cf12fb4505971bd2"; };
          Fabric-API = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/aQqNHHfZ/fabric-api-0.128.1%2B1.21.5.jar"; sha512 = "9ee7377f1d085d34363f3025a8ea55e3bf6e31732453a9e5ba3c5bd11dcb055636818c85bd55f17ec5f9078d6fa15361a8c302ed093677f5e9d09b4c17d74a41"; };
          FerriteCore = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/uXXizFIs/versions/CtMpt7Jr/ferritecore-8.0.0-fabric.jar"; sha512 = "131b82d1d366f0966435bfcb38c362d604d68ecf30c106d31a6261bfc868ca3a82425bb3faebaa2e5ea17d8eed5c92843810eb2df4790f2f8b1e6c1bdc9b7745"; };
          ImmediatelyFast = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/5ZwdcRci/versions/dk4uLLmV/ImmediatelyFast-Fabric-1.9.5%2B1.21.5.jar"; sha512 = "033cb2531931ff9800f219ca273e65147223a86dac832dadeaf7af32a69d05af6a8630a6cfe3c1aa61080854b3a3471307a8d48d166c3439bcfa9501c3ccf824"; };
          Lithium = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/xcELvp6R/lithium-fabric-0.16.3%2Bmc1.21.5.jar"; sha512 = "42d1538caa913bb35e76208efc14bce3e89fb01e8dbd7cf2a3b8576377d83d2d2f63a207cb7b6f081e20b00e5edff8d01e94a52d89e8c9ce9e3dfecc3fac4d78"; };
          # TODO: modernfix
          More-Culling = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/51shyZVL/versions/MDkI6Huh/moreculling-fabric-1.21.5-1.3.1.jar"; sha512 = "b207146df0ff4ba042e651722320430bae3708e6a6363229ed12c87df31181667a53ee622b85561e31fb3a1534444d48b8b7de9c4e0f174c12a4d7029d4e880a"; };
          No-Chat-Reports = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/qQyHxfxd/versions/CHlHxkvf/NoChatReports-FABRIC-1.21.5-v2.12.0.jar"; sha512 = "c0825db25672cf8b50face51ec8a6bedb4be50b374a2537640a433c98817bc07c177485e93ab8cee9e3f7bfb1d2eb1460309e818b411764c92426b552487a9f7"; };
          Noisium = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/KuNKN7d2/versions/sUh67T4Y/noisium-fabric-2.6.0%2Bmc1.21.5.jar"; sha512 = "4471b6137de7e2109987df8fe62ac836741e68ba3c57303a0f2dc362c0ab8e7aca656d28046e250362316c1144396132a5531dfb12b5a664c68eb294991af938"; };
          ScalableLux = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/Ps1zyz6x/versions/UueJNiJn/ScalableLux-0.1.3%2Bbeta.1%2Bfabric.4039a8d-all.jar"; sha512 = "144dd32f5f7b9c015ae2ff2efc8ba58c561d0fae7a22aba071f0d45f8b3154ae8d23783e9a0308c80eee51857a0ef68191c444830e5da3b44021f03b55a26da2"; };
          ThreadTweak = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/vSEH1ERy/versions/IvtlnXcT/threadtweak-fabric-0.1.7%2Bmc1.21.5.jar"; sha512 = "aec7e39b478d47dc96ba12291fd048ed9253c39d27a0c25b8565b3cef08eb5117b4f6bf2453c3377d2de739de8ba0501c77b291b6f0fc82559f0f30514a9125a"; };
          Very-Many-Players = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/wnEe9KBa/versions/EKg6v67t/vmp-fabric-mc1.21.5-0.2.0%2Bbeta.7.198-all.jar"; sha512 = "f6be6fcf949243bcca460acc113f799cb657ce81320c8f6fa4054e584d32512c538d30b5c6f6713f247fbb6122f4ab951a91c2a6c839e4680e196c707e1d4ffd"; };
        }
      );
    };
  };
}
