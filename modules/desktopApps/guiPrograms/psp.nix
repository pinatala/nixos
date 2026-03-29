{ config, self, ... }: {
  flake.nixosModules.psp = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      ppsspp
    ];
  };
}
