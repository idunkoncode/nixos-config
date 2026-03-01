{ lib, config, pkgs, ... }:

let cfg = config.obs; in

{
  options.obs.enable = lib.mkEnableOption "OBS Studio with plugins";

  config = lib.mkIf cfg.enable {
    programs.obs-studio = {
      enable = true;

      plugins = with pkgs.obs-studio-plugins; [
        obs-vkcapture
        obs-pipewire-audio-capture
        wlrobs
        obs-backgroundremoval
        obs-gstreamer
      ];
    };
  };
}
