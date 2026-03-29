{ config, self, ... }: {
  flake.nixosModules.fileManager = { pkgs, ... }: {
    environment = {
      systemPackages = with pkgs; [
        nautilus
        libheif
        libheif.out
      ];
      pathsToLink = [ "share/thumbnailers" ];
    };
    services = {
      gvfs.enable = true;
      udisks2.enable = true;
    };
  };
}
