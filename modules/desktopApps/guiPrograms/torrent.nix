{ config, self, ... }: {
  flake.nixosModules.torrent = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      qbittorrent
    ];
  };
}
