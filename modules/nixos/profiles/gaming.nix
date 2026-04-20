{
  flake.nixosModules.gaming = { lib, config, pkgs, ... }: {
    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
      "nvidia-x11"
      "nvidia-settings"
      "nvidia-persistenced"
      "steam"
      "steam-unwrapped"
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
    programs.steam = {
      enable = true;
      extraCompatPackages = [ pkgs.proton-ge-bin];
      package = pkgs.steam.override {
        extraEnv = {
          GAMEMODERUN = "1";
          __NV_PRIME_RENDER_OFFLOAD = "1";
          __GLX_VENDOR_LIBRARY_NAME = "nvidia";
          __VK_LAYER_NV_optimus = "NVIDIA_only";
          PROTON_LOCAL_SHADER_CACHE = "1";
          MESA_SHADER_CACHE_MAX_SIZE = "4G";
          MESA_GLSL_CACHE_MAX_SIZE = "4G";
          WINE_VK_VULKAN_ONLY = "1";
          WINEDLLOVERRIDES = "dinput8,dxgi,dsound=n,b";
          RADV_PERFTEST = "";
        };
      };
    };
    environment.systemPackages = with pkgs; [
      (bottles.override { removeWarningPopup = true;})
      mangohud
    ];
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
