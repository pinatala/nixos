{ config, self, ... }: {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      "*".addKeysToAgent = "yes";
      "github.com" = {
        hostname = "github.com";
        user = "git";
        identityFile = "/home/${self.user}/.config/sops-nix/secrets/github_ssh_key";
      };
    };
  };
  services.ssh-agent.enable = true;
}
