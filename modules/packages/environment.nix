{ lib, inputs, self, ... }: {
  perSystem = { pkgs, self', ... }: {
    packages.terminal =
      (inputs.wrappers.wrapperModules.kitty.apply {
        inherit pkgs;
        imports = [self.wrappersModules.kitty];
        shell = lib.getExe self'.packages.extra;
      }).wrapper;

    packages.extra = inputs.wrappers.lib.wrapPackage {
      inherit pkgs;
      package = self'.packages.zsh;
      runtimeInputs = [
        self'.packages.nvf
      ];
    };
  };
}

