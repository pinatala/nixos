{
  flake.nixosModules.gnome = { pkgs, ... }: {
    services.displayManager.gdm.enable = true;
    services.desktopManager.gnome.enable = true;
    services.gnome.core-apps.enable = false;
    services.gnome.core-developer-tools.enable = false;
    services.gnome.games.enable = false;
    environment.systemPackages = [ 
      pkgs.nautilus 
      pkgs.libheif
      pkgs.libheif.out
      pkgs.eog
    ];
    services.gvfs.enable = true;
    services.udisks2.enable = true;
    environment.pathsToLink = [ "share/thumbnailers" ];
  };
}
