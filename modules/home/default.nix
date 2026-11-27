{ self, inputs, lib, ... }: {
  # Agregator: otomatis memuat SEMUA flake.homeModules.* (kecuali dirinya sendiri).
  flake.homeModules.default = {
    imports = lib.attrValues (removeAttrs self.homeModules [ "default" ]);
  };

  # Integrasi sebagai modul NixOS.
  flake.nixosModules.homeManager = { ... }: {
    imports = [ inputs.home-manager.nixosModules.home-manager ];
    home-manager = {
      useUserPackages = true;
      users.${self.user}.imports = [ self.homeModules.default ];
    };
  };
}
