{ inputs, self, ... }: {
  flake.nixosConfigurations.rabbit = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.main
    ];
  };

  flake.nixosModules.main = { pkgs, lib, config, ... }: {
    imports = [
      self.nixosModules.hardware
      self.nixosModules.user
      self.nixosModules.disko
      self.nixosModules.impermanence
      self.nixosModules.gaming
      self.nixosModules.secureBoot
      self.nixosModules.zram
      self.nixosModules.time
      self.nixosModules.network
      self.nixosModules.keyboard
      self.nixosModules.print
      self.nixosModules.pipewire
    ];
    environment.systemPackages = [
      pkgs.brave
      pkgs.vesktop
      pkgs.standardnotes
      pkgs.fastfetch
      pkgs.proton-vpn
      pkgs.tree
      pkgs.wl-clipboard
      pkgs.btop
      pkgs.anki
      pkgs.sbctl
      pkgs.calibre
      pkgs.vlc
      self.packages.${pkgs.stdenv.hostPlatform.system}.kitty
      self.packages.${pkgs.stdenv.hostPlatform.system}.nvf
    ];

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
    services.syncthing = {
      enable = true;
      user = "luna";
      group = "users";
      dataDir = "/home/luna";
      configDir = "/home/luna/.config/syncthing";
    };
    services.displayManager.gdm.enable = true;
    services.desktopManager.gnome.enable = true;
    networking.hostName = "rabbit";
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    system.stateVersion = "25.11";
  };
}
