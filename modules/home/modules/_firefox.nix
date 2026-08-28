{ config, ... }: {
  programs.firefox = {
    enable = true;
    configPath = "${config.xdg.configHome}/mozilla/firefox";
    languagePacks = [ "en-US" ];
  
    policies = {
      # Updates & Background Services
      AppAutoUpdate = false;
      AIControls.Default = {
        "Value" = "blocked";
        "Locked" = true;
      };
      BackgroundAppUpdate = false;
      FirefoxHome = {
        Search = false;
        TopSites = false;
        SponsoredTopSites = false;
        Highlights = false;
        Pocket = false;
        Stories = false;
        SponsoredPocket = false;
        SponsoredStories = false;
        Snippets = false;
        Locked = false;
      };
      SearchSuggestEnabled = false;
      EnableTrackingProtection = {
        "Value" = true;
        "Locked" = true;
        Cryptomining = true;
        Fingerprinting = true;
        EmailTracking = true;
        SuspectedFingerprinting = true;
        Category = "strict";
      };
      DNSOverHTTPS = {
        "Enabled" = false;
        "Locked" = true;
      };
      Permissions = {
        Camera = {
          BlockNewRequests = true;
          "Locked" = true;
        };
        Microphone = {
          BlockNewRequests = true;
          "Locked" = true;
        };
        Location = {
          BlockNewRequests = true;
          "Locked" = true;
        };
        Notifications = {
          BlockNewRequests = true;
          "Locked" = true;
        };
        ScreenShare = {
          BlockNewRequests = true;
          "Locked" = true;
        };
      };
      HttpsOnlyMode = "force_enabled";
      TranslateEnabled = false;
      NetworkPrediction = false;
      BlockAboutConfig = true;
  
      # Feature Disabling
      DisableFirefoxStudies = true;
      DisableSetDesktopBackground = true;
      DisablePocket = true;
      DisableTelemetry = true;
  
      # UI and Behavior
      DontCheckDefaultBrowser = true;
      HardwareAcceleration = true;
  
      # Extensions
      ExtensionSettings = let
        moz = short: "https://addons.mozilla.org/firefox/downloads/latest/${short}/latest.xpi";
      in {
        "*".installation_mode = "blocked";
  
        "uBlock0@raymondhill.net" = {
          install_url       = moz "ublock-origin";
          installation_mode = "force_installed";
          updates_disabled  = true;
          private_browsing = true;
        };
      };
    };
  
    profiles.default.search = {
      force           = true;
      default         = "ddg";
      privateDefault  = "google";
    };
  };
}
