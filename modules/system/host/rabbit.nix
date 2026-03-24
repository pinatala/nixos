{ inputs, self, ... }: {
  systems = [ "x86_64-linux" ];
  flake.nixosConfigurations.rabbit = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = with self.nixosModules; [
      hardware
      defaultCore
      gnome
      secureBoot
      zram
      impermanence
      services
      luna
      nvf
      nvidia
      gaming
      flatpak
      disko
    ];
  };
}
