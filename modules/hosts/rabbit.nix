{ inputs, self, ... }: {
  flake.nixosConfigurations.rabbit = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      hardware
      core
      desktop
      desktopApps
      extra
      luna
      disko
      kitty
    ];
  };
}
