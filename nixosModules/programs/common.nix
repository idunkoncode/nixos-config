{ lib, config, pkgs, ... }:

let cfg = config.commonPackages; in

{
  options.commonPackages.enable = lib.mkEnableOption "common CLI packages";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      vim
      wget
      unzip
      fzf
      fd
      ripgrep
      eza
      bat
      fastfetch
      ghostty
      tree-sitter
    ];
  };
}
