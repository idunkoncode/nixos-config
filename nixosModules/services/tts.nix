{ lib, config, pkgs, ... }:

let cfg = config.ttsEngine; in

{
  options.ttsEngine.enable = lib.mkEnableOption "Piper TTS + speech-dispatcher";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      piper-tts
      sox
    ];

    services.speechd.enable = true;
  };
}
