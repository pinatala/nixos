{ config, self, ... }: {
  flake.nixosModules.eog = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      eog
    ];
  };
}
