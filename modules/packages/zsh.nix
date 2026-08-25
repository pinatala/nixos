{ self, inputs, ... }: {
  flake.wrapperModules.zsh = { config, lib, ... }: {
    settings = {
      shellAliases = {
        "rebuildBoot" = "sudo nixos-rebuild boot --flake .#rabbit";
        "rebuildSwitch" = "sudo nixos-rebuild switch --flake .#rabbit";
        "rebuildTest" = "sudo nixos-rebuild test --flake .#rabbit";
        "9router" = ''export PATH="$HOME/.npm-global/bin:$PATH" && 9router'';
      };
    };
  };
  perSystem = {pkgs, ...}: {
    packages.zsh =
      (inputs.wrappers.wrapperModules.zsh.apply {
        inherit pkgs;
        imports = [self.wrapperModules.zsh];
      }).wrapper;
  };
}
