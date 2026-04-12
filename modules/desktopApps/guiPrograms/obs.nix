{ config, self, ... }: {
  flake.nixosModules.obs = { pkgs, ... }: {
    programs.obs-studio = {
      enable = true;
    };
  };
}
