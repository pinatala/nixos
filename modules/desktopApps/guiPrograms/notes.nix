{ config, self, ... }: {
  flake.nixosModules.notes = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      standardnotes
    ];
  };
}
