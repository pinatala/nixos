{ config, self, ... }: {
  flake.nixosModules.btop = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      btop
    ];
  };
}
