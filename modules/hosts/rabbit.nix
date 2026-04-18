{ inputs, self, ... }: {
  flake.nixosConfigurations.rabbit = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.main
    ];
  };

  flake.nixosModules.main = { pkgs, config, ... }: {
    imports = [
      self.nixosModules.hardware
      self.nixosModules.general
      self.nixosModules.desktop
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
      user = "${self.user}";
      group = "users";
      dataDir = "/home/${self.user}";
      configDir = "/home/${self.user}/.config/syncthing";
    };
    fonts.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
    ];
    services.displayManager.gdm.enable = true;
    services.desktopManager.gnome.enable = true;
    networking.hostName = "rabbit";
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    system.stateVersion = "25.11";
  };
}
