{ inputs, ... }: {
  flake.nixosModules.nvf = { pkgs, ... }: {
    imports = [ inputs.nvf.nixosModules.default ];
    programs.nvf = {
      enable = true;
      settings = {
        vim = {
          theme = {
            enable = true;
            name = "catppuccin";
            style = "mocha";
          };
          utility.oil-nvim.enable = true;
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
    };
  };
}
