{
  disko.devices = {
    disk = {
      boot = {
        type = "disk";
        device = "/dev/disk/by-id/mmc-BJTD4R_0xbaf0bc01";
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
                mountOptions = [ "umask=0077" ];
              };
            };
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "zboot";
              };
            };
          };
        };
      };

      data1 = {
        type = "disk";
        device = "/dev/disk/by-id/ata-HGST_HUH721010ALE604_2YG92VHD";
        content = {
          type = "gpt";
          partitions = {
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "zbackup";
              };
            };
          };
        };
      };
      data2 = {
        type = "disk";
        device = "/dev/disk/by-id/ata-HGST_HUH721010ALE604_2YGLWT4D";
        content = {
          type = "gpt";
          partitions = {
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "zbackup";
              };
            };
          };
        };

      };
    };
    zpool = {

      zboot = {
        type = "zpool";
        options = {
          ashift = "12";
        };
        rootFsOptions = {
          # ashift = "12";
          # autotrim = "on";
          acltype = "posixacl";
          atime = "off";
          canmount = "off";
          compression = "zstd";
          dnodesize = "auto";
          normalization = "formD";
          xattr = "sa";
          mountpoint = "none";
        };
        datasets = {
          nix = {
            type = "zfs_fs";
            mountpoint = "/nix";
          };
          persist = {
            type = "zfs_fs";
            mountpoint = "/persist";
          };
        };
      };

      zbackup = {
        type = "zpool";
        mode.topology = {
          type = "topology";
          vdev = [
            {
              mode = "mirror";
              members = [ "data1" "data2"];
            }
          ];
        };
        options = {
          ashift = "12";
        };
        rootFsOptions = {
          # autotrim = "on";
          acltype = "posixacl";
          atime = "off";
          canmount = "off";
          compression = "zstd";
          dnodesize = "auto";
          normalization = "formD";
          xattr = "sa";
          mountpoint = "none";
        };
        datasets = {
          data = {
            type = "zfs_fs";
            options.mountpoint = "/backup";
          };
        };
      };

    };

    nodev."/" = {
      fsType = "tmpfs";
      mountOptions = [
        "size=2G"
        "defaults"
        "mode=755"
      ];
    };
  };

  fileSystems = {
    "/".neededForBoot = true;
    "/nix".neededForBoot = true;
    "/boot".neededForBoot = true;
    "/persist".neededForBoot = true;
  };

  boot.zfs.extraPools = [ "zbackup" ];
}
