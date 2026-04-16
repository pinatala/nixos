{ inputs, ... }: {
  flake.homeModules = {

    git = { pkgs, ... }: {
      programs.git = {
        enable = true;
        settings.user = {
          name = "najika12";
          email = "iqromaulanahadi@gmail.com";
        };
        settings = {
          init.defaultBranch = "main";
          url."ssh://git@github.com/".insteadOf = "https://github.com/";
        };
      };
    };

    sops = { pkgs, config, ... }: {
      imports = [ inputs.sops-nix.homeManagerModules.sops ];
      sops = {
        defaultSopsFile = ./secrets.yaml;
        age.keyFile = "/home/luna/.config/sops/age/keys.txt";
        secrets."github_ssh_key" = {
          path = "/home/luna/.ssh/id_ed25519";
          mode = "0600";
        };
      };
    };

    ssh = { config, pkgs, ... }: {
      programs.ssh = {
        enable = true;
        enableDefaultConfig = false;
        matchBlocks = {
          "*".addKeysToAgent = "yes";
          "github.com" = {
            hostname = "github.com";
            user = "git";
            identityFile = config.sops.secrets.github_ssh_key.path;
          };
        };
      };
      services.ssh-agent.enable = true;
    };
  };
}
