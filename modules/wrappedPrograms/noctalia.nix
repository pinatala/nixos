{ self, inputs, ... }: {
  perSystem = { pkgs, ... }: {
    packages.noctalia-shell = inputs.wrapper-modules.wrappers.noctalia-shell.wrap {
      inherit pkgs;
      env = {
        "NOCTALIA_CACHE_DIR" = "/tmp/noctalia-cache/";
      };
      settings = {
        general.reverseScroll = true;
        sessionMenu.largeButtonsStyle = false;
        wallpaper.enabled = false;
        location.weatherEnabled = false;
        nightLight = {
          enabled = true;
          forced = true;
          autoSchedule = false;
        };
      };
      colors = { # Catppuccin Mocha
        mError = "#f38ba8";
        mHover = "#cba6f7";
        mOnError = "#11111b";
        mOnHover = "#11111b";
        mOnPrimary = "#11111b";
        mOnSecondary = "#11111b";
        mOnSurface = "#cdd6f4";
        mOnSurfaceVariant = "#89b4fa";
        mOnTertiary = "#11111b";
        mOutline = "#45475a";
        mPrimary = "#b4befe";
        mSecondary = "#f5c2e7";
        mShadow = "#11111b";
        mSurface = "#1e1e2e";
        mSurfaceVariant = "#313244";
        mTertiary = "#cba6f7";
      };
    };
  };
}
