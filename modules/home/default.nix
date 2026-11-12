{ self, inputs, ... }: {
  flake.nixosModules.homeManager = { pkgs, ... }: {
    imports = [ inputs.home-manager.nixosModules.home-manager ];
    home-manager = {
      useUserPackages = true;
      extraSpecialArgs = { inherit inputs self; };
      users.${self.user} = { pkgs, ... }: {
        imports = [
          ./modules/_stylix.nix
          ./modules/_kitty.nix
          ./modules/_zsh.nix
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
    users.mutableUsers = false;
    users.users.${self.user} = {
      isNormalUser = true;
      description = "${self.user}'s account";
      extraGroups = [ "networkmanager" "wheel" "gamemode" ];
      hashedPassword = "$y$j9T$GcsKnUBjJUttltpTFEl4b.$mBKEArl8/I1F02y8JQDVjCOUtSJQrhU6QwF2Q1IXDz9"; # mkpasswd -m yescrypt
      #password = "123";
      packages = with pkgs; [
      ];
    };
  };
}
