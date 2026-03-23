{ inputs, self, ... }: {
  flake.nixosModules.services = { ... }: {
    imports = [
      self.nixosModules.btrfs
      self.nixosModules.fail2ban
      self.nixosModules.firewall
      self.nixosModules.pipewire
      self.nixosModules.print
      self.nixosModules.resolved
      self.nixosModules.syncthing
      self.nixosModules.xserver
    ];
  };
}
