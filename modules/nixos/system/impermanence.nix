{ inputs, ... }: {
  flake.nixosModules.impermanence = { config, lib, ... }: {
    imports = [ inputs.impermanence.nixosModules.impermanence ];
    boot.initrd.systemd.enable = true;

    boot.initrd.systemd.services.rollback = {
      description = "Rollback Btrfs root to blank snapshot";
      wantedBy = [ "initrd.target" ];
      after = [ "cryptsetup.target" ];
      before = [ "sysroot.mount" ];
      unitConfig.DefaultDependencies = "no";
      serviceConfig.Type = "oneshot";
      script = ''
        mkdir -p /mnt
        mount -t btrfs /dev/mapper/crypted /mnt

        echo "Deleting nested subvolumes in /mnt/root..."

        # Hapus subvolume anak-anak dulu
        btrfs subvolume list -o /mnt/root | cut -f9 -d' ' | while read subvolume; do
          echo "Deleting /$subvolume subvolume..."
          btrfs subvolume delete "/mnt/$subvolume"
        done

        echo "Deleting /root subvolume..."
        btrfs subvolume delete /mnt/root

        echo "Restoring blank /root subvolume..."
        btrfs subvolume snapshot /mnt/root-blank /mnt/root

        umount /mnt
        echo "Rollback done."
      '';
    };

    environment.persistence."/persist" = {
      hideMounts = true;
      directories = [
        { directory = "/etc/NetworkManager/system-connections"; mode = "0600"; }
      ];
      files = [
        "/etc/plasmalogin.conf"
      ];
    };
  };
}
