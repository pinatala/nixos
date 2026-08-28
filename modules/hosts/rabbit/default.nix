{ inputs, self, ... }: {
  flake.nixosConfigurations.rabbit = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.rabbit
    ];
  };

  flake.nixosModules.rabbit = { pkgs, config, ... }: {
    imports = [
      self.nixosModules.hardware
      self.nixosModules.diskRabbit
      self.nixosModules.homeManager
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
      kernelPackages = pkgs.linuxPackages_7_1;
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
    programs.partition-manager.enable = true;
    nixpkgs.config.allowUnfree = true;
    hardware.bluetooth.enable = true;
    services.displayManager.plasma-login-manager.enable = true;
    services.desktopManager.plasma6.enable = true;
    networking.hostName = "rabbit";
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    system.stateVersion = "26.05";
  };
}
