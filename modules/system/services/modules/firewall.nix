{ inputs, ... }: {
  flake.nixosModules.firewall = { pkgs, ... }: {
    networking.firewall = {
      enable = true;
      allowedTCPPorts = [ 53317 22000 ];
    };  
  };
}
