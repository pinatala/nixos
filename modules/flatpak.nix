{ inputs, ... }: {
  flake.nixosModules.flatpak = { pkgs, ... }: {
    imports = [ inputs.flatpak.nixosModules.default ];
    services.flatpak = {
      enable = true;
      forceRunOnActivation = true;
      remotes = {
        "flathub" = "https://dl.flathub.org/repo/flathub.flatpakrepo";
      };
      packages = [
        "flathub:app/org.telegram.desktop/x86_64/stable"
        "flathub:app/dev.vencord.Vesktop/x86_64/stable"
      ];
      overrides = {
        "global".Context = {
          filesystems = [
            "!home"
            "/home/luna/Flatpak"
          ];
          sockets = [
            "wayland"
            "!fallback-x11"
            "!x11"
          ];
        };
      };
    };
    xdg.portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
      ];
      config = {
        common.default = ["gtk"];
      };
    };
  };
}
