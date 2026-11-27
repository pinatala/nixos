{ inputs, ... }: {
  flake.nixosModules.gnome = { pkgs, ... }: {
    services.displayManager.gdm.enable = true;
    services.desktopManager.gnome.enable = true;
    services.gnome.core-apps.enable = false;
    services.gnome.core-developer-tools.enable = false;
    services.gnome.games.enable = false;
    environment.systemPackages = [ 
      pkgs.nautilus 
      pkgs.libheif
      pkgs.libheif.out
      pkgs.eog
    ];
    services.gvfs.enable = true;
    services.udisks2.enable = true;
    environment.pathsToLink = [ "share/thumbnailers" ];
  };
  flake.homeModules.gnome = { pkgs, ... }: {
    imports = [ inputs.stylix.homeModules.stylix ];
    stylix = {
      enable = true;
      autoEnable = false;
      image = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/pinatala/nixos/refs/heads/main/assets/wallpapers/dominik-mayer-24.jpg";
        hash = "sha256-j6AonV/8BeuceGFhpCwTY0T4BmCLXfw67fnQ99+oGyc="; # openssl dgst -sha256 -binary file_name | openssl base64 -A
      };
      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
      targets.gnome = {
        enable = true;
        colors.enable = false;
        fonts.enable = false;
        imageScalingMode.enable = false;
        inputs.enable = false;
        polarity.enable = false;
        image.enable = true;
      };
    };
    dconf = {
      enable = true;
      settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
    };
    services.udiskie.enable = true;
  };
}
