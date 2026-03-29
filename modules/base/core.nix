{ inputs, ... }: {
  flake.nixosModules.core = { pkgs, ... }: {
    boot = {
      loader = {
        efi = {
          efiSysMountPoint = "/boot";
          canTouchEfiVariables = true;
        };
        systemd-boot = {
          enable = true;
          configurationLimit = 10;
        };
      };
      resumeDevice = "/dev/mapper/crypted"; 
      kernelParams = [ "resume_offset=533760" ]; # sudo btrfs inspect-internal map-swapfile -r /path/to/subvolumes/swapfile
      kernelPackages = pkgs.linuxPackages_6_18;
      initrd.systemd.enable = true;
    };
    services.btrfs.autoScrub = {
      enable = true;
      interval = "weekly";
      fileSystems = ["/"];
    };
    networking.hostName = "rabbit";
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    system.stateVersion = "25.11";
  };
}
