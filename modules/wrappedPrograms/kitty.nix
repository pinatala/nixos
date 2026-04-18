{ self, inputs, ... }: {
  flake.wrappersModules.kitty = { config, lib, ... }: {
    options.shell = lib.mkOption {
      type = lib.types.str;
      default = "";
    };
    config = {
      args = lib.mkAfter (lib.optionals (config.shell != "") [config.shell]);
      settings = {
        enable_audio_bell = "no";

        font_size = 15;
        font_family = "JetBrainsMono Nerd Font";

        allow_remote_control = "yes";
        shell_integration = "enabled";

        cursor_trail = 3;

        map = [
          "alt+1 goto_tab 1"
          "alt+2 goto_tab 2"
          "alt+3 goto_tab 3"
          "alt+4 goto_tab 4"
          "alt+5 goto_tab 5"
          "alt+6 goto_tab 6"
          "alt+7 goto_tab 7"
          "alt+8 goto_tab 8"
          "alt+9 goto_tab 9"
          "ctrl+shift+w close_tab"
          "ctrl+t new_tab_with_cwd"
          "ctrl+shift+t new_tab"
        ];

        background = self.theme.crust;
        foreground = self.theme.text;
        cursor = self.theme.rosewater;

        mark1_background = self.theme.lavender;
        mark1_foreground = self.theme.crust;
        mark2_background = self.theme.mauve;
        mark2_foreground = self.theme.crust;
        mark3_background = self.theme.sapphire;
        mark3_foreground = self.theme.crust;

        cursor_text_color = self.theme.crust;
#        selection_foreground = self.theme.mauve;
        selection_background = self.theme.overlay2;
#        active_foreground = self.theme.base0B;
#        active_background = self.theme.base03;
#        inactive_tab_background = self.theme.base01;
        color0 = self.theme.surface1;
        color1 = self.theme.red;
        color2 = self.theme.green;
        color3 = self.theme.yellow;
        color4 = self.theme.blue;
        color5 = self.theme.pink;
        color6 = self.theme.teal;
        color7 = self.theme.subtext0;
        color8 = self.theme.surface2;
        color15 = self.theme.subtext1;
        color16 = self.theme.peach;
        color17 = self.theme.rosewater;
      };
    };
  };

  perSystem = {pkgs, ...}: {
    packages.kitty =
      (inputs.wrappers.wrapperModules.kitty.apply {
        inherit pkgs;
        imports = [self.wrappersModules.kitty];
      }).wrapper;
  };
}
