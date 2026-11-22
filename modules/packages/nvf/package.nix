{ self, inputs, ... }: {
  perSystem = { pkgs, config, ... }: {
    packages.nvf = (inputs.nvf.lib.neovimConfiguration {
      inherit pkgs;
      modules = [
        self.nixosModules.nvf
      ];
    }).neovim;
  };
}
