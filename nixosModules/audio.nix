{ lib, config, pkgs, ... }:

let cfg = config.audio; in

{
  options.audio.enable = lib.mkEnableOption "audio (PipeWire + RNNoise noise cancellation)";

  config = lib.mkIf cfg.enable {
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;

      # RNNoise noise cancellation filter-chain.
      # Creates a virtual mic "Noise Cancellation Microphone" apps can select.
      extraConfig.pipewire."99-rnnoise" = {
        "context.modules" = [
          {
            name = "libpipewire-module-filter-chain";
            args = {
              "node.description" = "Noise Cancellation";
              "media.name"       = "Noise Cancellation";

              "filter.graph".nodes = [
                {
                  type    = "ladspa";
                  name    = "rnnoise";
                  plugin  = "${pkgs.rnnoise-plugin}/lib/ladspa/librnnoise_ladspa.so";
                  label   = "noise_suppressor_stereo";
                  control = {
                    "VAD Threshold (%)"         = 50.0;
                    "VAD Grace Period (ms)"      = 200;
                    "Retroactive VAD Grace (ms)" = 0;
                  };
                }
              ];

              "capture.props" = {
                "node.name"        = "rnnoise_source";
                "node.description" = "Noise Cancellation Microphone";
                "media.class"      = "Audio/Source";
                "audio.position"   = [ "FL" "FR" ];
              };

              "playback.props" = {
                "node.name"      = "rnnoise_sink";
                "node.description" = "Noise Cancellation Sink";
                "media.class"    = "Audio/Sink";
                "node.passive"   = true;
                "audio.position" = [ "FL" "FR" ];
              };
            };
          }
        ];
      };
    };
  };
}
