{ inputs, self, ...}: {
  flake.wrapperModules.niri = { config, lib, pkgs, ... }: {
    options = {
      terminal = lib.mkOption {
        type = lib.types.str;
        default = "kitty";
      };
    };
    config = {
      settings = let
        noctaliaExe = lib.getExe self.packages.${config.pkgs.stdenv.hostPlatform.system}.noctalia-shell;
      in {
        spawn-at-startup = [
          noctaliaExe
          (lib.getExe (
            config.pkgs.writeShellScriptBin "wallpaper"
            "${lib.getExe config.pkgs.swaybg} -i ${./../features/wallpaper/disco-elysium-artwork.jpg} -m fill"
          ))
        ];
        input = {
          keyboard.xkb.layout = "us";
          touchpad = {
            natural-scroll = null;
            tap = null;
          };
        };
        prefer-no-csd = null;
        window-rule = {
          focus-ring = {
            width = 2;
            active-color = "#b4befe";
          };
          geometry-corner-radius = 10;
          clip-to-geometry = true;
        };
        xwayland-satellite.path = lib.getExe config.pkgs.xwayland-satellite;
        layout.gaps = 4;
        binds = {
          "Mod+Return".spawn = config.terminal;
          "Print".spawn-sh = ''${lib.getExe config.pkgs.flameshot} gui'';
          "Mod+R".spawn-sh = ''${lib.getExe config.pkgs.obs-studio} --startrecording'';
          "Mod+B".spawn-sh = ''${lib.getExe config.pkgs.brave} --new-window'';
          "Mod+Ctrl+B".spawn-sh = ''${lib.getExe config.pkgs.brave} --new-window --incognito'';
          "Mod+Q".close-window = null;
          "Mod+F".maximize-column = null;
          "Mod+Ctrl+F".fullscreen-window = null;
        };
      };
    };
  };
  perSystem = {pkgs, ...}: {
    packages.niri = inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs;
      imports = [self.wrapperModules.niri];
    };
  };
}
