{ inputs, ... }: {
  flake.nixosModules.syncthing = { ... }: {
    services.syncthing = {
      enable = true;
      user = "luna";
      group = "users";
      dataDir = "/home/luna";
      configDir = "/home/luna/.config/syncthing";
    };
  };
}
