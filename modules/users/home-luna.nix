{ inputs, self, ... }: {
  flake.nixosModules.luna = { pkgs, ... }: {
    imports = [ inputs.home-manager.nixosModules.home-manager ];
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = { inherit inputs self; };
      users.luna = { pkgs, ... }: {
        imports = [
          self.homeModules.git
          self.homeModules.ssh
          self.homeModules.sops
          self.homeModules.kitty
        ];
        home = {
          username = "luna";
          homeDirectory = "/home/luna";
          stateVersion = "25.11";
          packages = with pkgs; [
             jetbrains-mono
             noto-fonts
             noto-fonts-cjk-sans
             noto-fonts-cjk-serif
             noto-fonts-color-emoji
             literata
          ];
        };
        programs.home-manager.enable = true;
      };
    };
    users.users.luna = {
      isNormalUser = true;
      description = "Luna";
      extraGroups = [ "networkmanager" "wheel" "gamemode" ];
      hashedPassword = "$6$amB55.SO6ApwkPyz$tvjJqab.kBV2cZf0CVJHAoGunMJCL1D3CU6uI4dJrD2AAtGrieAfW3J/142ocOHo9slYETriNlT.rbdU2PTz2/";
      packages = with pkgs; [
      ];
    };
  };
}
