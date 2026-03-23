{ inputs, ... }: {
  flake.nixosModules.btrfs = { pkgs, ... }: {
    services.btrfs.autoScrub = {
      enable = true;
      interval = "weekly";
      fileSystems = ["/"];
    };
  };
}
