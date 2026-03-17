{ inputs, ... }: {
  flake.nixosModules.defaultCore = { pkgs, ... }: {
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
    networking.networkmanager = {
      enable = true;
      wifi.scanRandMacAddress = true;
      wifi.macAddress = "random";
    };
    time.timeZone = "Asia/Jakarta";
    i18n.defaultLocale = "en_US.UTF-8";
    environment.systemPackages = with pkgs; [
      brave
      vesktop
      standardnotes
      fastfetch
      protonvpn-gui
      tree
      wl-clipboard
      btop
      anki
      sbctl
    ];
    networking.hostName = "rabbit";
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    system.stateVersion = "25.11";
  };
}
