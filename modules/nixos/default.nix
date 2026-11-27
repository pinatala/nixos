{ self, lib, ... }:
let
  # Modul yang TIDAK ikut dimuat otomatis ke semua host:
  # agregator, modul khusus host, modul opt-in, dan yang bukan modul NixOS.
  optOut = [
    "default"
    "rabbit"
    "hardwareRabbit"
    "diskRabbit"
    "graphicsRabbit"
  ];
in {
  flake.nixosModules.default = {
    imports = lib.attrValues (removeAttrs self.nixosModules optOut);
  };
}
