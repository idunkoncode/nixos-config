{ lib, config, ... }:

let cfg = config.firefox; in

{
  options.firefox.enable = lib.mkEnableOption "Firefox with privacy settings";

  config = lib.mkIf cfg.enable {
    programs.firefox = {
      enable = true;

      profiles.itsthicc = {
        settings = {
          "browser.startup.homepage"                         = "about:blank";
          "browser.newtabpage.enabled"                       = false;
          "privacy.trackingprotection.enabled"               = true;
          "privacy.trackingprotection.emailtracking.enabled" = true;
          "browser.toolbars.bookmarks.visibility"            = "never";
          "datareporting.healthreport.uploadEnabled"         = false;
          "toolkit.telemetry.enabled"                        = false;
        };
      };
    };
  };
}
