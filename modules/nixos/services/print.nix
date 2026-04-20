{
  flake.nixosModules.print = { pkgs, ... }: {
    services.printing.enable = true;
  };
}
