{ inputs, self, ... }: {
  flake.nixosConfigurations.rabbit = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.rabbit
    ];
  };

  flake.nixosModules.rabbit = { ... }: {
    imports = [
      self.nixosModules.hardwareRabbit
      self.nixosModules.diskRabbit
      self.nixosModules.graphicsRabbit
      self.nixosModules.base
      self.nixosModules.desktop
      self.nixosModules.users
      self.nixosModules.homeManager
      self.nixosModules.syncthing
    ];
    boot = {
      resumeDevice = "/dev/mapper/crypted"; 
      kernelParams = [ "resume_offset=533760" ]; # sudo btrfs inspect-internal map-swapfile -r /path/to/subvolumes/swapfile
    };
    networking.hostName = "rabbit";
    system.stateVersion = "26.05";
  };
}
