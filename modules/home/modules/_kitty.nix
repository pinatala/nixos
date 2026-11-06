{ lib, ... }: {
  programs.kitty = lib.mkForce {
    enable = true;
    settings = {
      font_size = 15;
      font_family = "JetBrainsMono Nerd Font";
      shell_integration = "enabled";
      confirm_os_window_close = 0;
      shell = "zsh";
#      dynamic_background_opacity = true;
      enable_audio_bell = false;
      mouse_hide_wait = "-1.0";
#      window_padding_width = 10;
#      background_opacity = "0.5";
#      background_blur = 5;
#      symbol_map = let
#        mappings = [
#          "U+23FB-U+23FE"
#        ];
#      in
#        (builtins.concatStringsSep "," mappings) + " Symbols Nerd Font";
    };
  };
}
