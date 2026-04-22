{ self, ... }: {
  flake.nixosModules.desktop = { pkgs, lib, config, ... }: {
    imports = [
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
      pkgs.firefox
      pkgs.vesktop
      pkgs.standardnotes
      pkgs.fastfetch
      pkgs.proton-vpn
      pkgs.tree
      pkgs.wl-clipboard
      pkgs.btop
      pkgs.keepassxc
      pkgs.libreoffice
      pkgs.cryptomator
      pkgs.localsend
      pkgs.signal-desktop
      pkgs.qbittorrent
      pkgs.anki
      pkgs.sbctl
      pkgs.calibre
      self.packages.${pkgs.stdenv.hostPlatform.system}.kitty
      self.packages.${pkgs.stdenv.hostPlatform.system}.nvf
    ];
  };
}
