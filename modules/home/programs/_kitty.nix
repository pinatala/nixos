{ lib, ... }: {
  programs.kitty = lib.mkForce {
    enable = true;
    settings = {
      font_size = 14;
      font_family = "JetBrainsMono Nerd Font";
      shell_integration = "enabled";
      confirm_os_window_close = 0;
      shell = "zsh";
      enable_audio_bell = false;
      mouse_hide_wait = "-1.0";
    };
  };
}
