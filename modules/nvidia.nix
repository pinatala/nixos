{ inputs, ... }: {
  flake.nixosModules.nvidia = { lib, config, pkgs, ... }: {
    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
      "nvidia-x11"
      "nvidia-settings"
      "nvidia-persistenced"
    ];
    services.xserver.videoDrivers = [
      "modesetting"
      "nvidia"
    ];
    hardware = {
      graphics.enable = true;
      nvidia = {
        package = config.boot.kernelPackages.nvidiaPackages.production;
        modesetting.enable = true;
        nvidiaSettings = true;
        open = false;
        prime = {
          sync.enable = true;
          intelBusId = "PCI:0:2:0";
          nvidiaBusId = "PCI:4:0:0";
        };
      };
    };
  };
}
