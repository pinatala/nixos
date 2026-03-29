{ config, self, ... }: {
  flake.nixosModules.sbctl = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      sbctl
    ];
  };
}
