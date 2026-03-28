{ inputs, self, ... }: {
  flake.nixosConfigurations.rabbit = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      hardware
      defaultCore
      desktop
      secureBoot
      zram
      impermanence
      services
      luna
      nvf
      gaming
      flatpak
      disko
    ];
  };
}
