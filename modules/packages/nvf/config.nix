{
  flake.nixosModules.nvf = { pkgs, config, ... }: {
    config.vim = {
      theme = {
        enable = true;
        name = "catppuccin";
        style = "mocha";
      };
      visuals.indent-blankline.enable = true;
      telescope.enable = true;
      treesitter = {
        enable = true;
      };
      languages = {
        nix = {
          enable = true;
          lsp.enable = true;
        };
      };
    };
  };
}
