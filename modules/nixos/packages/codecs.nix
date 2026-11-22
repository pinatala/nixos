{
  flake.nixosModules.codecs = { pkgs, ... }: {
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
    ];
  };
}
