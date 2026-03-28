{ lib, inputs, self, ... }: {
  flake.nixosModules.wm = { pkgs, lib, ... }: {
    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.wm;
    };
  };
  perSystem = { pkgs, self', ... }: {
    packages.wm = (inputs.wrappers.wrapperModules.niri.apply ({config, ...}: {
      inherit pkgs;
      imports = [self.wrapperModules.niri];
    })).wrapper;
  };
}
