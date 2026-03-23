{ inputs, ... }: {
  flake.homeModules = {
    git = import ./modules/git.nix;
    sops = import ./modules/sops.nix;
    ssh = import ./modules/ssh.nix;
    kitty = import ./modules/kitty.nix;
  };
}
