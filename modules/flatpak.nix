{ inputs, ... }: {
  flake.nixosModules.flatpak = { pkgs, ... }: {
    imports = [ inputs.nix-flatpak.nixosModules.nix-flatpak ];
    services.flatpak = {
      enable = true;
      update.onActivation = true;
      remotes = [
        {
          name = "flathub";
          location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
        }
      ];
      packages = [
        { appId = "org.cryptomator.Cryptomator"; origin = "flathub"; }
        { appId = "org.ppsspp.PPSSPP"; origin = "flathub"; }
        { appId = "org.qbittorrent.qBittorrent"; origin = "flathub"; }
        { appId = "org.localsend.localsend_app"; origin = "flathub"; }
        { appId = "org.libreoffice.LibreOffice"; origin = "flathub"; }
        { appId = "org.keepassxc.KeePassXC"; origin = "flathub"; }
        { appId = "com.usebottles.bottles"; origin = "flathub"; }
        { appId = "org.telegram.desktop"; origin = "flathub"; }
        { appId = "de.schmidhuberj.Flare"; origin = "flathub"; }
      ];
      overrides = {
        global = {
          Context = {
            filesystems = [
              "!home"
              "/home/luna/Flatpak"
            ];
            sockets = [
              "wayland"
              "!fallback-x11"
              "!x11"
              "!pulseaudio"
              "!ssh-auth"
              "!cups"
              "!pcsc"
            ];
          };
          "Session Bus Policy" = {
            "org.gnome.ScreenSaver" = "none";
            "org.freedesktop.ScreenSaver" = "none";
            "org.gnome.SessionManager" = "none";
            "org.freedesktop.Notifications" = "talk";
            "org.freedesktop.portal.RemoteDesktop" = "none";
            "org.freedesktop.portal.ScreenCast" = "none";
            "org.freedesktop.portal.Clipboard" = "none";
            "org.freedesktop.portal.Desktop" = "talk";
            "org.freedesktop.secrets" = "none";
            "org.gnome.keyring" = "none";
            "org.gnome.Shell" = "none";
            "org.gnome.Shell.Extensions" = "none";
            "org.gnome.PowerManager" = "none";
            "org.gnome.SettingsDaemon.Power" = "none";
          };
          "System Bus Policy" = {
            "org.freedesktop.login1" = "none";
            "org.freedesktop.UPower" = "none";
            "org.freedesktop.NetworkManager" = "none";
            "org.freedesktop.PackageKit" = "none";
            "org.freedesktop.Avahi" = "none";
            "org.freedesktop.PolicyKit1" = "none";
          };
        };
        "org.cryptomator.Cryptomator" = {
          Context = {
            sockets = [ "x11" "!wayland" ];
          };
          "Session Bus Policy" = {
            "org.freedesktop.secrets" = "talk";
          };
        };
        "org.telegram.desktop".Context.sockets = [ "pulseaudio" ];
        "com.usebottles.bottles".Context.sockets = [ "fallback-x11" "pulseaudio" "!wayland" ];
        "org.ppsspp.PPSSPP".Context.sockets = [ "fallback-x11" "pulseaudio" "!wayland" ];
      };
    };
    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
      config.common.default = [ "gtk" ];
    };
  };
}
