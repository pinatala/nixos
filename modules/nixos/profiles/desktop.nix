{ self, ... }: {
  flake.nixosModules.desktop = { pkgs, lib, config, ... }: {
    imports = [
      #self.nixosModules.impermanence
      self.nixosModules.gaming
      #self.nixosModules.secureBoot
      self.nixosModules.zram
      self.nixosModules.time
      self.nixosModules.network
      self.nixosModules.keyboard
      self.nixosModules.print
      self.nixosModules.pipewire
    ];
    environment.systemPackages = [
      pkgs.google-chrome
      pkgs.obsidian
      pkgs.tree
      pkgs.rar
      pkgs.localsend
      pkgs.ppsspp
      pkgs.vlc
      pkgs.opencode
      pkgs.wl-clipboard
      pkgs.localsend
      pkgs.qbittorrent
      pkgs.sbctl
      pkgs.nodejs_26
      pkgs.wireguard-tools
      self.packages.${pkgs.stdenv.hostPlatform.system}.terminal
    ];
  };
}
