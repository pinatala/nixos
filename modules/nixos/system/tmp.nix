{
  flake.nixosModules.tmp = { ... }: {
    boot.tmp.useTmpfs = true;
  };
}
