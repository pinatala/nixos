{ self, pkgs, ... }: {
  home = {
    username = "${self.user}";
    homeDirectory = "/home/${self.user}";
    stateVersion = "26.05";
    packages = with pkgs; [
    ];
  };
  programs.home-manager.enable = true;
}
