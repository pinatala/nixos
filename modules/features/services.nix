{ inputs, self, ... }: {
  flake.nixosModules.services = { ... }: {
    imports = with self.nixosModules; [
      btrfs
      chrony
      fail2ban
      firewall
      pipewire
      print
      resolved
      syncthing
      xserver
    ];
  };
}
