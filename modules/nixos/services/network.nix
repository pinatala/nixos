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
        allowedTCPPorts = [ 53317 22000 ];
      };
    };
    services.fail2ban = {
      enable = true;
      ignoreIP = [ "127.0.0.1/8" ];
      bantime = "60m";
      maxretry = 5;
    };  
  };
}
