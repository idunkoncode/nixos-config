{ config, pkgs, ... }:

{
  home.username = "drlight";
  home.homeDirectory = "/home/drlight";
  home.stateVersion = "25.11";
  programs.git.enable = true;
  programs.bash = {
    enable = true;
    shellAliases = {
      btw = "echo i use nixos, btw";
    };
  };
}
