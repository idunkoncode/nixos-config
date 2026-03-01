{ lib, config, pkgs, ... }:

let cfg = config.devPackages; in

{
  options.devPackages.enable = lib.mkEnableOption "development packages (rustup, git)";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      rustup
      git
    ];
  };
}
