{ inputs, self, ... }: {
  flake.nixosModules.desktop = { pkgs, lib, config, ... }: {
    imports = [
      self.nixosModules.disko
      self.nixosModules.impermanence
      self.nixosModules.gaming
      self.nixosModules.secureBoot
      self.nixosModules.zram
      self.nixosModules.time
      self.nixosModules.network
      self.nixosModules.keyboard
      self.nixosModules.print
      self.nixosModules.pipewire
    ];
    environment.systemPackages = [
      pkgs.brave
      pkgs.vesktop
      pkgs.standardnotes
      pkgs.fastfetch
      pkgs.proton-vpn
      pkgs.tree
      pkgs.wl-clipboard
      pkgs.btop
      pkgs.anki
      pkgs.sbctl
      pkgs.calibre
      pkgs.vlc
      self.packages.${pkgs.stdenv.hostPlatform.system}.kitty
      self.packages.${pkgs.stdenv.hostPlatform.system}.nvf
    ];
  };
}
