{ lib, config, pkgs, ... }:

let cfg = config.extraShells; in

{
  options.extraShells.enable = lib.mkEnableOption "extra shells (fish, nushell, xonsh, oh-my-posh)";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      fish
      nushell
      xonsh
      oh-my-posh
    ];

    programs.fish.enable = true;
  };
}
