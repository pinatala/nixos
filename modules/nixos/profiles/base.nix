{ self, ... }: {
  flake.nixosModules.base = { ... }: {
    imports = [
      self.nixosModules.boot
      self.nixosModules.nixSettings
      self.nixosModules.storage
      self.nixosModules.impermanence
      self.nixosModules.zram
      self.nixosModules.tmp
      self.nixosModules.time
      self.nixosModules.locale
      self.nixosModules.network
      self.nixosModules.fail2ban
      self.nixosModules.sudo
    ];
  };
}
