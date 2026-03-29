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
      bottles
      brave
      calibre
      cryptomator
      eog
      fileManager
      notes
      obs
      office
      psp
      signal
      torrent
      vesktop
      vlc
      vpn
    ];
  };
}
