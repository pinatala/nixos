{
  flake.nixosModules.sudo = { ... }: {
    security.sudo.extraConfig = ''
      Defaults lecture = never
    '';
  };
}
