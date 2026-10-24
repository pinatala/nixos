{ self, inputs, ... }: {
  flake.nixosModules.homeManager = { pkgs, ... }: {
    imports = [ inputs.home-manager.nixosModules.home-manager ];
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = { inherit inputs self; };
      users.${self.user} = { pkgs, ... }: {
        imports = [
          ./modules/_git.nix
          ./modules/_sops.nix
          ./modules/_ssh.nix
        ];
        home = {
          username = "${self.user}";
          homeDirectory = "/home/${self.user}";
          stateVersion = "26.05";
          packages = with pkgs; [
          ];
        };
        programs.home-manager.enable = true;
      };
    };
    users.users.${self.user} = {
      isNormalUser = true;
      description = "${self.user}'s account";
      extraGroups = [ "networkmanager" "wheel" ];
      password = "123";
      packages = with pkgs; [
      ];
    };
  };
}
