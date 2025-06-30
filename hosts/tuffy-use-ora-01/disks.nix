{
  disko.devices = {
    disk = {
      a = {
        type = "disk";
        device = "/dev/disk/by-id/wwn-0x60666d8363ae4cefa7140cee635f3106";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              type = "EF00";
              size = "512M";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            persist = {
              # Nominally just system files,
              # and another disk gets mounted
              # for larger data
              size = "10G";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/persist";
              };
            };
            nix = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/nix";
              };
            };
            swap = {
              size = "5G";
              content = {
                type = "swap";
                discardPolicy = "both";
                resumeDevice = true;
              };
            };
          };
        };
      };
    
      # how to add device not required for boot???
      big-persist = {
        type = "disk";
        device = "/dev/disk/by-id/wwn-0x60cd12a44b0e47f8b677323f38bbd379";
        content = {
          type = "gpt";
          partitions = {
            data = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/big-persist";
                mountOptions = [ "nofail" ];
              };
            };
          };
        };
      };
    };
    nodev = {
      "/" = {
        fsType = "tmpfs";
        mountOptions = [
          # Typical usage on / tends to be around
          # 1G. This should avoid pressure, especially
          # with separate other partitions, and can
          # easily be adjusted later.
          "size=2G"
          "defaults"
          "mode=755"
        ];
      };
      "/tmp" = {
        fsType = "tmpfs";
        mountOptions = [
          "size=2G"
          "defaults"
          "nodev"
          "nosuid"
          # Minecraft mods write executables here
          # e.g. sqlite shared library. This is unfortunate
          # and I hope to find a way around it.
#          "noexec"
          "mode=1777"
        ];
      };
      "/var" = {
        fsType = "tmpfs";
        mountOptions = [
          "size=4G"
          "defaults"
          "mode=755"
        ];
      };
      # /var/log gets persisted to disk
      "/home" = {
        fsType = "tmpfs";
        mountOptions = [
          "size=2G"
          "defaults"
          "nodev"
          "nosuid"
          "mode=755"
        ];
      };
    };
  };

  fileSystems = {
    "/boot".neededForBoot = true;
    "/persist".neededForBoot = true;
    "/big-persist".neededForBoot = true;
    "/nix".neededForBoot = true;
    "/".neededForBoot = true;
    "/tmp".neededForBoot = true;
    "/var".neededForBoot = true;
    "/home".neededForBoot = true;
  };
}
