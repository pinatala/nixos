{ inputs, ... }: {
  flake.nixosModules.loginManager = { pkgs, ... }: {
    services.displayManager.gdm.enable = true;
  };
}
