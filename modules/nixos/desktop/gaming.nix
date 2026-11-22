{
  flake.nixosModules.gaming = { lib, config, pkgs, ... }: {
#    programs.steam = {
#      enable = true;
#      extraCompatPackages = [ pkgs.proton-ge-bin];
#      package = pkgs.steam.override {
#        extraEnv = {
#          GAMEMODERUN = "1";
#          __NV_PRIME_RENDER_OFFLOAD = "1";
#          __GLX_VENDOR_LIBRARY_NAME = "nvidia";
#          __VK_LAYER_NV_optimus = "NVIDIA_only";
#          PROTON_LOCAL_SHADER_CACHE = "1";
#          MESA_SHADER_CACHE_MAX_SIZE = "4G";
#          MESA_GLSL_CACHE_MAX_SIZE = "4G";
#          WINE_VK_VULKAN_ONLY = "1";
#          WINEDLLOVERRIDES = "dinput8,dxgi,dsound=n,b";
#          RADV_PERFTEST = "";
#        };
#      };
#    };
#    environment.systemPackages = with pkgs; [
#      #(bottles.override { removeWarningPopup = true;})
#      mangohud
#    ];
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
