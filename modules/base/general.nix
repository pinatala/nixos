{ self, inputs, ... }: {
  flake.nixosModules.general = { lib, pkgs, ... }: {
    imports = [ inputs.home-manager.nixosModules.home-manager ];
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = { inherit inputs self; };
      users.${self.user} = { pkgs, ... }: {
        imports = [
          self.homeModules.git
          self.homeModules.sops
          self.homeModules.ssh
        ];
        home = {
          username = "${self.user}";
          homeDirectory = "/home/${self.user}";
          stateVersion = "25.11";
          packages = with pkgs; [
             jetbrains-mono
             noto-fonts
             noto-fonts-cjk-sans
             noto-fonts-cjk-serif
             noto-fonts-color-emoji
          ];
        };
        programs.home-manager.enable = true;
      };
    };
    users.users.${self.user} = {
      isNormalUser = true;
      description = "${self.user}'s account";
      extraGroups = [ "networkmanager" "wheel" "gamemode" ];
      hashedPassword = "$6$amB55.SO6ApwkPyz$tvjJqab.kBV2cZf0CVJHAoGunMJCL1D3CU6uI4dJrD2AAtGrieAfW3J/142ocOHo9slYETriNlT.rbdU2PTz2/";
      packages = with pkgs; [
      ];
    };
  };
}
