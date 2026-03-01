{ lib, config, pkgs, ... }:

let cfg = config.desktop; in

{
  options.desktop.enable = lib.mkEnableOption "desktop environment (Qtile + KDE Plasma + SDDM)";

  config = lib.mkIf cfg.enable {
    services.xserver.enable = true;

    services.xserver.windowManager.qtile = {
      enable = true;
      extraPackages = python3Packages: with python3Packages; [ qtile-extras ];
    };

    services.desktopManager.plasma6.enable = true;

    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };

    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };

    fonts.packages = with pkgs; [
      nerd-fonts.terminess-ttf
    ];
  };
}
