{ inputs, ... }: {
  flake.nixosModules.disko = {
    imports = [ inputs.disko.nixosModules.disko ];
    disko.devices = {
      disk = {
        main = {
          type = "disk";
          device = "/dev/disk/by-id/ata-V-GEN12SM22AR256SDK_256GB_VGAR2022121400000023"; # ls /dev/disk/by-id/
          content = {
            type = "gpt";
            partitions = {
              boot = {
                size = "1M";
                type = "EF02";
                priority = 1;
              };
              ESP = {
                size = "1G";
                type = "EF00";
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot";
                  mountOptions = [ "umask=0077" ];
                };
              };
              luks = {
                size = "100%";
                content = {
                  type = "luks";
                  name = "crypted";
                  extraOpenArgs = [ "--allow-discards" ]; # Matikan jika menggunakan HDD
                  settings = {
                    allowDiscards = true;
                  };
                  content = {
                    type = "btrfs";
                    extraArgs = ["-L" "nixos" "-f"];
                    subvolumes = {
                      "/root" = {
                        mountpoint = "/";
                        mountOptions = ["subvol=root" "compress=zstd" "noatime"];
                      };
                      "/root-blank" = {
                        mountOptions = ["subvol=root-blank" "nodatacow" "noatime"];
                      };
                      "/home" = {
                        mountpoint = "/home";
                        mountOptions = ["subvol=home" "compress=zstd" "noatime"];
                      };
                      "/home-blank" = {
                        mountOptions = ["subvol=home-blank" "nodatacow" "noatime"];
                      };
                      "/nix" = {
                        mountpoint = "/nix";
                        mountOptions = ["subvol=nix" "compress=zstd" "noatime"];
                      };
                      "/persist" = {
                        mountpoint = "/persist";
                        mountOptions = ["subvol=persist" "compress=zstd" "noatime"];
                      };
                      "/log" = {
                        mountpoint = "/var/log";
                        mountOptions = ["subvol=log" "compress=zstd" "noatime"];
                      };
                      "/lib" = {
                        mountpoint = "/var/lib";
                        mountOptions = ["subvol=lib" "compress=zstd" "noatime"];
                      };
                      "/persist/swap" = {
                        mountpoint = "/persist/swap";
                        mountOptions = ["subvol=swap" "noatime" "nodatacow" "compress=no"];
                        swap.swapfile.size = "8G";
                      };
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
    fileSystems."/persist".neededForBoot = true;
    fileSystems."/var/log".neededForBoot = true;
    fileSystems."/var/lib".neededForBoot = true;
  };
}
