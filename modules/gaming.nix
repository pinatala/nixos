{ inputs, ... }: {
  flake.nixosModules.gaming = { pkgs, ... }: {
    hardware.graphics = {
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

    programs.gamemode = {
      enable = true;
      enableRenice = true;
      settings = {
        general = {
          renice = 10;
        };
      };
    };

    environment.systemPackages = with pkgs; [
      (bottles.override { removeWarningPopup = true; })
      wineWowPackages.waylandFull
    ];
  };
}
