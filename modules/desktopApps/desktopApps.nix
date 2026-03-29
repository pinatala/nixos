{ config, self, ... }: {
  flake.nixosModules.desktopApps = { pkgs, ... }: {
    imports = with self.nixosModules; [
      # CLI Programs
      btop
      clipboard
      fastfetch
      nvf
      sbctl
      syncthing
      tree
      # GUI Programs
      brave
      calibre
      eog
      fileManager
      flatpak
      notes
      obs
      vesktop
      vlc
      vpn
    ];
  };
}
