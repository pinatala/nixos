{ inputs, ... }:
{
  flake.nixosModules.zram = { lib, config, ... }: 
  let
    cfg = config.custom.zram;
  in
  {
    options.custom.zram = {
      enable = lib.mkEnableOption "Enable zram module";
    };
    config = {
      custom.zram.enable = true;
      boot.tmp.useTmpfs = true;
      zramSwap = lib.mkIf cfg.enable {
        enable = true;
        algorithm = "zstd";
        priority = 5;
        memoryPercent = 50;
      };
    };
  };
}
