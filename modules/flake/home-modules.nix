# Mendeklarasikan output flake `homeModules` & `homeConfigurations` agar bisa
# didefinisikan dari banyak file sekaligus (sama seperti `nixosModules` bawaan flake-parts).
{ lib, ... }: {
  options.flake = {
    homeModules = lib.mkOption {
      type = lib.types.lazyAttrsOf lib.types.deferredModule;
      default = { };
      description = "Modul Home Manager (output flake `homeModules`).";
    };
    homeConfigurations = lib.mkOption {
      type = lib.types.lazyAttrsOf lib.types.raw;
      default = { };
      description = "Konfigurasi Home Manager standalone (output flake `homeConfigurations`).";
    };
  };
}
