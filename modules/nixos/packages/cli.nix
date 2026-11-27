{
  flake.nixosModules.cli = { pkgs, ... }: {
    environment.systemPackages = [
      # cli
      pkgs.fastfetch
      pkgs.tree
      pkgs.rar
      pkgs.unrar
      pkgs.btop
      pkgs.smassh
      pkgs.wl-clipboard
      pkgs.sbctl
    ];
  };
}
