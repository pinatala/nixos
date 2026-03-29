{ config, self, ... }: {
  flake.nixosModules.calibre = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      calibre
    ];
  };
}
