{ lib, config, ... }:

let cfg = config.ttsConfig; in

{
  options.ttsConfig.enable = lib.mkEnableOption "per-user speech-dispatcher config using piper TTS";

  config = lib.mkIf cfg.enable {
    # Before first use, download a voice model:
    #   mkdir -p ~/.local/share/piper
    #   wget -P ~/.local/share/piper \
    #     https://huggingface.co/rhasspy/piper-voices/resolve/main/en/en_US/ryan/high/en_US-ryan-high.onnx \
    #     https://huggingface.co/rhasspy/piper-voices/resolve/main/en/en_US/ryan/high/en_US-ryan-high.onnx.json

    xdg.configFile."speech-dispatcher/speechd.conf".text = ''
      LogLevel 3
      DefaultModule piper
      DefaultLanguage "en-US"
      DefaultRate 0
      DefaultPitch 0
      DefaultVolume 100
      AudioOutputMethod pulse
    '';

    xdg.configFile."speech-dispatcher/modules/piper.conf".text = ''
      GenericExecuteSynth "piper --model /home/itsthicc/.local/share/piper/en_US-ryan-high.onnx --output_raw | sox -t raw -r 22050 -e signed -b 16 -c 1 - -t wav - | $PLAY_COMMAND"
      GenericLanguage "en"
      GenericRate "-5"
      GenericPitch "0"
      GenericVolume "100"
    '';
  };
}
