{ inputs, ... }: {
  flake.nixosModules.resolved = { pkgs, ... }: {
    services.resolved = {
      enable = true;
      settings = {
        Resolve = {
          DNS = "9.9.9.9#dns.quad9.net 149.112.112.112#dns.quad9.net";
          FallbackDNS = [ "9.9.9.9" "149.112.112.112" ];
          DNSOverTLS = true;
          DNSSEC = true;
          Domains = [];
        };
      };
    };
  };
}
