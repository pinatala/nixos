{ self, ... }: {
  flake.nixosModules.cli = { pkgs, ... }: {
    environment.systemPackages = [
      # cli
      pkgs.fastfetch
      pkgs.tree
      pkgs.yazi
      pkgs.rar
      pkgs.unrar
      pkgs.smassh
      pkgs.wl-clipboard
      pkgs.sbctl
      self.packages.${pkgs.stdenv.hostPlatform.system}.nvf
    ];
  };
}
