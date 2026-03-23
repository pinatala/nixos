{ inputs, ... }: {
  flake.nixosModules.nvidia = { lib, config, pkgs, ... }: {
    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
      "nvidia-x11"
      "nvidia-settings"
      "nvidia-persistenced"
    ];
    services.xserver.videoDrivers = [
      "nvidia"
    ];
    hardware = {
      graphics.enable = true;
      nvidia = {
        package = config.boot.kernelPackages.nvidiaPackages.production;
        modesetting.enable = true;
        nvidiaSettings = true;
        open = false;
      };
    };
  };
}
