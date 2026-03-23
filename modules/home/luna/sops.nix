{ pkgs, inputs, ... }: {
  imports = [ inputs.sops-nix.homeManagerModules.sops ];
  sops = {
    defaultSopsFile = ./../../system/users/luna/secrets.yaml;
    age.keyFile = "/home/luna/.config/sops/age/keys.txt";
    secrets."github_ssh_key" = {
      path = "/home/luna/.ssh/id_ed25519";
      mode = "0600";
    };
  };
}
