{ inputs, ... }: {
  flake.nixosModules.gaming = { lib, config, pkgs, ... }: {
    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
      "nvidia-x11"
      "nvidia-settings"
      "nvidia-persistenced"
    ];
    services.xserver.videoDrivers = [
      "nvidia"
    ];
    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with pkgs; [
          intel-media-driver
          libvdpau-va-gl
        ];
        extraPackages32 = with pkgs; [
          driversi686Linux.mesa
        ];
      };
      nvidia = {
        package = config.boot.kernelPackages.nvidiaPackages.stable;
        nvidiaSettings = false;
        open = false;
        modesetting.enable = true;
        prime = {
          nvidiaBusId = "PCI:1@0:0:0";
          intelBusId = "PCI:0@0:2:0";
          sync.enable = true;
        };
      };
    };
    programs.gamemode = {
      enable = true;
      enableRenice = true;
      settings = {
        general = {
          renice = 10;
        };
      };
    };
  };
}
