{
  flake.nixosModules.boot = { pkgs, ... }: {
    boot = {
      loader = {
        efi = {
          efiSysMountPoint = "/boot";
          canTouchEfiVariables = true;
        };
        limine.enable = true;
        limine.secureBoot.enable = true;
      };
      kernelPackages = pkgs.linuxPackages_6_18;
    };
  };
}
