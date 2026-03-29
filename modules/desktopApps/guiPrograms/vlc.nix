{ config, self, ... }: {
  flake.nixosModules.vlc = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      vlc
    ];
  };
}
