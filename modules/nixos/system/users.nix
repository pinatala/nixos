{ self, ... }: {
  flake.nixosModules.users = { pkgs, ... }: {
    users.mutableUsers = false;
    users.users.${self.user} = {
      isNormalUser = true;
      description = "${self.user}'s account";
      extraGroups = [ "networkmanager" "wheel" "gamemode" ];
      hashedPassword = "$y$j9T$GcsKnUBjJUttltpTFEl4b.$mBKEArl8/I1F02y8JQDVjCOUtSJQrhU6QwF2Q1IXDz9"; # mkpasswd -m yescrypt
      packages = with pkgs; [
      ];
    };
  };
}
