{
  disko.devices = {
    disk = {
      a = {
        type = "disk";
        device = "/dev/sda";
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
          "noexec"
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
    "/nix".neededForBoot = true;
    "/".neededForBoot = true;
    "/tmp".neededForBoot = true;
    "/var".neededForBoot = true;
    "/home".neededForBoot = true;
  };
}
