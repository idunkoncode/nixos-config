{ lib, config, pkgs, ... }:

let cfg = config.qbittorrent; in

{
  options.qbittorrent.enable = lib.mkEnableOption "qBittorrent";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ qbittorrent ];
  };
}
