{ self, inputs, ... }: {
  # Opsional: home-manager standalone (home-manager switch --flake .#luna@rabbit)
  flake.homeConfigurations."${self.user}@rabbit" =
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = import inputs.nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
      modules = [ self.homeModules.default ];
    };
}
