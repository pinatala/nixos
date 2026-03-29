{ config, self, ... }: {
  flake.nixosModules.localsend = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      localsend
    ];
  };
}
