{ lib, config, pkgs, ... }:

let cfg = config.gaming; in

{
  options.gaming.enable = lib.mkEnableOption "gaming packages (Steam, GameMode, MangoHud, launchers)";

  config = lib.mkIf cfg.enable {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      gamescopeSession.enable = true;
      extraCompatPackages = with pkgs; [ proton-ge-bin ];
    };

    programs.gamemode.enable = true;
    programs.mangohud.enable = true;

    environment.systemPackages = with pkgs; [
      gamescope
      lutris
      heroic
      bottles
      protonup-qt
      winetricks
      vulkan-tools
      vulkan-loader
      antimicrox
    ];

    hardware.xpadneo.enable = true;

    # OBS virtual camera kernel module
    boot.extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
    boot.kernelModules = [ "v4l2loopback" ];
    boot.extraModprobeConfig = ''
      options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
    '';
  };
}
