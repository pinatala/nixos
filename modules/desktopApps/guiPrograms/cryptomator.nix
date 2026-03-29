{ config, self, ... }: {
  flake.nixosModules.cryptomator = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      cryptomator
    ];
  };
}
