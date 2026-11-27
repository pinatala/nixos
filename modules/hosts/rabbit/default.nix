{ inputs, self, ... }: {
  flake.nixosConfigurations.rabbit = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.rabbit
    ];
  };

  flake.nixosModules.rabbit = { ... }: {
    imports = [
      # khusus host ini
      self.nixosModules.hardwareRabbit
      self.nixosModules.diskRabbit
      self.nixosModules.graphicsRabbit
      # semua modul umum (system, desktop, services, users, homeManager, ...)
      self.nixosModules.default
    ];
    boot = {
      resumeDevice = "/dev/mapper/crypted"; 
      kernelParams = [ "resume_offset=533760" ]; # sudo btrfs inspect-internal map-swapfile -r /path/to/subvolumes/swapfile
    };
    networking.hostName = "rabbit";
    system.stateVersion = "26.05";
  };
}
