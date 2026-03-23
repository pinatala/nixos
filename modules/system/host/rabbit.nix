{ inputs, self, ... }: {
  systems = [ "x86_64-linux" ];
  flake.nixosConfigurations.rabbit = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      ./../../../hardware-configuration.nix
      self.nixosModules.defaultCore
      self.nixosModules.gnome
      self.nixosModules.secureBoot
      self.nixosModules.zram
      self.nixosModules.impermanence
      self.nixosModules.services
      self.nixosModules.luna
      self.nixosModules.nvf
      self.nixosModules.nvidia
      self.nixosModules.gaming
      self.nixosModules.flatpak
      self.nixosModules.disko
    ];
  };
}
