{
  flake.nixosModules.network = { pkgs, ... }: {
    networking = {
      networkmanager = {
        enable = true;
        wifi.scanRandMacAddress = true;
        wifi.macAddress = "random";
      };
      firewall = {
        enable = true;
        allowedTCPPorts = [ 53317 59100 ];
      };
    };
  };
}
