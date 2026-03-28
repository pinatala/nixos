{ config, self, ... }: {
  flake.nixosModules.desktop = { pkgs, ... }: {
    imports = [
      self.nixosModules.gdm
      self.nixosModules.wm
    ];
  };
}
