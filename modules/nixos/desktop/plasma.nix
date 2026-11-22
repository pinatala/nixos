{
  flake.nixosModules.plasma = { ... }: {
    programs.partition-manager.enable = true;
    services.desktopManager.plasma6.enable = true;
    services.displayManager.plasma-login-manager.enable = true;
  };
}
