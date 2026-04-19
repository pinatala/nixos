{ config, self, ... }: {
  flake.nixosModules.keyboard = { pkgs, ... }: {
    services.xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
    };
    i18n.defaultLocale = "en_US.UTF-8";
  };
}
