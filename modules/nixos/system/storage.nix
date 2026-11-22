{
  flake.nixosModules.storage = { ... }: {
    services.btrfs.autoScrub = {
      enable = true;
      interval = "weekly";
      fileSystems = ["/"];
    };
    services.udisks2.enable = true;
  };
}
