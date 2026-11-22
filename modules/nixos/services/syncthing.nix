{ self, ... }: {
  flake.nixosModules.syncthing = { ... }: {
    services.syncthing = {
      enable = true;
      user = "${self.user}";
      group = "users";
      dataDir = "/home/${self.user}";
      configDir = "/home/${self.user}/.config/syncthing";
    };
  };
}
