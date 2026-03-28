{ inputs, ... }: {
  flake.nixosModules.chrony = { pkgs, ... }: {
    services.chrony = {
      enable = true;
      enableNTS = true;
      extraConfig = ''
        server time.cloudflare.com iburst nts
        server ntppool1.time.nl iburst nts
        server nts.netnod.se iburst nts
        server ptbtime1.ptb.de iburst nts
        server time.dfm.dk iburst nts
        server time.cifelli.xyz iburst nts
      '';
    };
  };
}
