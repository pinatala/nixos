{
  flake.nixosModules.graphicsRabbit = { lib, config, pkgs, ... }: {
    services.xserver.videoDrivers = [
      "nvidia"
      "modesetting"
    ];
    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with pkgs; [
          libva-vdpau-driver
          intel-media-driver
          libvdpau-va-gl
          nvidia-vaapi-driver
        ];
        extraPackages32 = with pkgs; [
          driversi686Linux.mesa
        ];
      };
      nvidia = {
        package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
        dynamicBoost.enable = true;
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
  };
}
