{ pkgs, inputs, config, lib, ... }: {
  imports = [ inputs.stylix.homeModules.stylix ];
  stylix = {
    enable = true;
    autoEnable = false;
    image = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/pinatala/nixos/refs/heads/main/modules/nixos/wallpaper/dominik-mayer-24.jpg";
      hash = "sha256-j6AonV/8BeuceGFhpCwTY0T4BmCLXfw67fnQ99+oGyc=";
    };
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    targets = {
      kde.enable = true;
      kitty.enable = true;
    };
  };
}
