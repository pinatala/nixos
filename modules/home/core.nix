{ self, ... }: {
  flake.homeModules.core = { lib, ... }: {
    home = {
      username = lib.mkDefault self.user;
      homeDirectory = lib.mkDefault "/home/${self.user}";
      stateVersion = "26.05";
    };
    programs.home-manager.enable = true;
  };
}
