{ pkgs, ... }: {
  programs.kitty = {
    enable = true;
    font.name = "JetBrains Mono Regular";
    themeFile = "Catppuccin-Mocha";
    extraConfig = ''
      confirm_os_window_close 0
      font_size 12.0
   '';
  };
}
