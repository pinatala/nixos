{
  flake.homeModules.ghostty = { pkgs, ... }: {
    programs.ghostty = {
      enable = true;
      package = if pkgs.stdenv.isDarwin then pkgs.ghostty-bin else pkgs.ghostty;
      enableZshIntegration = true;
      settings = {
        font-family = "JetBrainsMono Nerd Font";
        theme = "Catppuccin Mocha";
        background-opacity = "0.95";
        command = "zsh --login";
      };
    };
  };
}
