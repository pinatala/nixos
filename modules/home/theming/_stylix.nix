{ pkgs, inputs, ... }: {
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
}
