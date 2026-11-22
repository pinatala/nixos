{ self, ... }: {
  flake.nixosModules.desktop = { ... }: {
    imports = [
      self.nixosModules.plasma
      self.nixosModules.fonts
      self.nixosModules.bluetooth
      self.nixosModules.keyboard
      self.nixosModules.pipewire
      self.nixosModules.print
      self.nixosModules.flatpak
      self.nixosModules.gaming
      self.nixosModules.codecs
      self.nixosModules.cli
    ];
  };
}
