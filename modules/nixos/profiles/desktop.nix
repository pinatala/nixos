{ self, ... }: {
  flake.nixosModules.desktop = { pkgs, lib, config, ... }: {
    imports = [
      self.nixosModules.gaming
      #self.nixosModules.zram
      #self.nixosModules.stylix
      self.nixosModules.time
      self.nixosModules.network
      self.nixosModules.keyboard
      self.nixosModules.print
      self.nixosModules.pipewire
    ];
    environment.systemPackages = [
      # codec
      pkgs.ffmpeg-full
      pkgs.gst_all_1.gstreamer
      pkgs.gst_all_1.gst-plugins-base
      pkgs.gst_all_1.gst-plugins-good
      pkgs.gst_all_1.gst-plugins-bad
      pkgs.gst_all_1.gst-plugins-ugly
      pkgs.gst_all_1.gst-libav
      pkgs.libaom

      pkgs.fastfetch
      pkgs.tree
      pkgs.rar
      pkgs.unrar
      pkgs.wl-clipboard
      self.packages.${pkgs.stdenv.hostPlatform.system}.nvf
    ];
  };
}
