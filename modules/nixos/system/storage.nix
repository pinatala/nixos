{
  flake.nixosModules.storage = { ... }: {
    services.btrfs.autoScrub = {
      enable = true;
      interval = "weekly";
      fileSystems = ["/"];
    };
  };
}
