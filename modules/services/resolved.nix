{ inputs, ... }: {
  flake.nixosModules.resolved = { pkgs, ... }: {
    services.resolved = {
      enable = true;
      dnssec = "true";
      domains = [ "~." ];
      fallbackDns = [ "9.9.9.9" "149.112.112.112" ];
      extraConfig = ''
        DNS=9.9.9.9#dns.quad9.net 149.112.112.112#dns.quad9.net
        DNSOverTLS=yes
      '';
    };
  };
}
