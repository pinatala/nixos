{ config, self, ... }: {
  flake.nixosModules.extra = { pkgs, ... }: {
    imports = with self.nixosModules; [
      gaming
      impermanence
      keyboard
      loginManager
      network
      pipewire
      print
      secureBoot
      time
      zram
    ];
  };
}
