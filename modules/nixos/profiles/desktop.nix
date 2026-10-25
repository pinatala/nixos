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
      pkgs.fastfetch
      pkgs.tree
      pkgs.rar
      pkgs.unrar
      pkgs.wl-clipboard
      pkgs.wireguard-tools
      self.packages.${pkgs.stdenv.hostPlatform.system}.terminal
    ];
  };
}
