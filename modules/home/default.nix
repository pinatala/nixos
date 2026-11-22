{ self, inputs, ... }: {
  flake.nixosModules.homeManager = { ... }: {
    imports = [ inputs.home-manager.nixosModules.home-manager ];
    home-manager = {
      useUserPackages = true;
      extraSpecialArgs = { inherit inputs self; };
      users.${self.user} = { ... }: {
        imports = [
          ./_core.nix
          ./theming/_stylix.nix
          ./programs/_kitty.nix
          ./programs/_zsh.nix
          ./programs/_git.nix
          ./security/_sops.nix
          ./security/_ssh.nix
        ];
      };
    };
  };
}
