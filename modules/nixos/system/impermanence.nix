{ inputs, self, ... }: {
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

    boot.initrd.systemd.services.rollback-home = {
      description = "Rollback Btrfs home to blank";
      wantedBy = [ "initrd.target" ];
      after = [ "cryptsetup.target" ];
      before = [ "sysroot.mount" ];
      unitConfig.DefaultDependencies = "no";
      serviceConfig.Type = "oneshot";
      script = ''
        mkdir -p /mnt
        mount -t btrfs /dev/mapper/crypted /mnt
        btrfs subvolume list -o /mnt/home | cut -f9 -d' ' | while read subvolume; do
          btrfs subvolume delete "/mnt/$subvolume"
        done
        btrfs subvolume delete /mnt/home
        btrfs subvolume snapshot /mnt/home-blank /mnt/home
        umount /mnt
      '';
    };

    environment.persistence."/persist" = {
      hideMounts = true;
      directories = [
        { directory = "/etc/NetworkManager/system-connections"; mode = "0600"; }
      ];

      users.${self.user} = {
        directories = [

          # Flatpak
          ".var/app/ai.storyteller.wordcraft"
          ".var/app/com.bitwarden.desktop"
          ".var/app/com.brave.Browser"
          ".var/app/com.github.tchx84.Flatseal"
          ".var/app/com.vysp3r.ProtonPlus"
          ".var/app/net.audiorelay.AudioRelay"
          ".var/app/net.lutris.Lutris"
          ".var/app/org.freedownloadmanager.Manager"
          ".var/app/org.localsend.localsend_app"
          ".var/app/org.rncbc.qpwgraph"
          ".var/app/org.videolan.VLC"

          # Data lu
          "Documents"
          "Downloads"
          "Pictures"
          "Videos"
          "Music"
          "Projects"
          "Games"
          "nixos"

          # Syncthing
          ".config/syncthing"
        ];
      };
    };
    security.sudo.extraConfig = ''
      Defaults lecture = never
    '';
  };
}
