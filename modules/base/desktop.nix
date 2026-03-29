{ config, self, ... }: {
  flake.nixosModules.desktop = { pkgs, ... }: {
    imports = [
      self.nixosModules.loginManager
      self.nixosModules.wm
    ];
  };
}
