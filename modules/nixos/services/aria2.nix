{
  flake.nixosModules.aria2 = { pkgs, ... }: {
    services.aria2 = {
      enable = true;
      settings = {
        dir = "~/Downloads";
        #enable-rpc = true;
      };
    };
  };
}
