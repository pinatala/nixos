{ config, self, ... }: {
  flake.nixosModules.clipboard = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      wl-clipboard
    ];
  };
}
