{ config, ... }: {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      "*".addKeysToAgent = "yes";
      "github.com" = {
        hostname = "github.com";
        user = "git";
        identityFile = config.sops.secrets.github_ssh_key.path;
      };
    };
  };
  services.ssh-agent.enable = true;
}
