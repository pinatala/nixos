{ inputs, self, ... }: {
  systems = [ "x86_64-linux" ];
  flake.nixosConfigurations.rabbit = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      ./../../hardware-configuration.nix
      self.nixosModules.defaultCore
      self.nixosModules.gnome
      self.nixosModules.secureBoot
      self.nixosModules.btrfs
      self.nixosModules.zram
      self.nixosModules.impermanence
      self.nixosModules.fail2ban
      self.nixosModules.firewall
      self.nixosModules.pipewire
      self.nixosModules.print
      self.nixosModules.resolved
      self.nixosModules.xserver
      self.nixosModules.luna
      self.nixosModules.syncthing
      self.nixosModules.nvf
      self.nixosModules.nvidia
      self.nixosModules.gaming
      self.nixosModules.flatpak
      self.nixosModules.disko
    ];
  };
}
