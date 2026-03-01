{ lib, config, pkgs, inputs, ... }:

let cfg = config.emacs; in

{
  imports = [ inputs.nix-doom-emacs-unstraightened.homeModule ];

  options.emacs.enable = lib.mkEnableOption "Doom Emacs";

  config = lib.mkIf cfg.enable {
    programs.doom-emacs = {
      enable = true;
      doomDir = ../doom;   # homeManagerModules/doom/{init,config,packages}.el
    };
  };
}
