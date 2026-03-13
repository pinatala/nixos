{ inputs, ... }: {
  flake.nixosModules.xserver = { pkgs, ... }: {
    services.xserver.enable = true;
    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };
  };
}
