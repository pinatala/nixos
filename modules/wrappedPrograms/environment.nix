{ config, self, ... }: {
  flake.nixosModules.kitty = { pkgs, ... }: {
     environment.systemPackages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.kitty
    ];   
  };
}
