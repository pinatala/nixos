{ self, inputs, ... }: {
  imports = [ inputs.sops-nix.homeManagerModules.sops ];
  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.keyFile = "/var/lib/sops/age/keys.txt";
    secrets."github_ssh_key" = {
      path = "/var/lib/.ssh/id_ed25519";
      mode = "0600";
    };
  };
}
