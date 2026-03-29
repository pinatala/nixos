{ config, self, ... }: {
  flake.nixosModules.fastfetch = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      fastfetch
    ];
  };
}
