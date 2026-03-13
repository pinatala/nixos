{ inputs, ... }: {
  flake.nixosModules.impermanence = { config, lib, ... }: {
    imports = [ inputs.impermanence.nixosModules.impermanence ];
    boot.initrd.systemd.services.rollback = {
      description = "Rollback root btrfs subvolume to blank snapshot";
      wantedBy = [ "initrd.target" ];
      after = [ "systemd-cryptsetup@crypted.service" ];
      before = [ "sysroot.mount" ];
      unitConfig.DefaultDependencies = "no";
      serviceConfig.Type = "oneshot";
      script = ''
        mkdir -p /mnt
        mount -t btrfs /dev/mapper/crypted /mnt

        # Recursively delete all nested subvolumes inside /mnt/root
        btrfs subvolume list -o /mnt/root | cut -f9 -d' ' | while read subvolume; do
          echo "Deleting /$subvolume subvolume..."
          btrfs subvolume delete "/mnt/$subvolume"
        done

        echo "Deleting /root subvolume..."
        btrfs subvolume delete /mnt/root

        echo "Restoring blank /root subvolume..."
        btrfs subvolume snapshot /mnt/root-blank /mnt/root

        umount /mnt
      '';
    };
    environment.persistence."/persist" = {
      directories = [
        "/etc/nixos"
        "/var/spool"
        "/var/lib/flatpak"
        "/srv"
        "/etc/NetworkManager/system-connections"
        "/var/lib/bluetooth"
        "/var/lib/sbctl"
      ];
      files = [
        # "/etc/machine-id"
        # Add more files you want to persist
      ];
    };
    # optional quality of life setting
    security.sudo.extraConfig = ''
      Defaults lecture = never
    '';
  };
}
