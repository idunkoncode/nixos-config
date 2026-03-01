{ inputs, pkgs, ... }:

{
  imports = [ ../../homeManagerModules ];

  home.username = "itsthicc";
  home.homeDirectory = "/home/itsthicc";
  home.stateVersion = "25.11";

  programs.ssh = {
    enable        = true;
    addKeysToAgent = "yes";  # prompt once per session, then cache in agent
    matchBlocks = {
      "github.com"   = { identityFile = "~/.ssh/nix-os"; };
      "gitlab.com"   = { identityFile = "~/.ssh/nix-os"; };
      "codeberg.org" = { identityFile = "~/.ssh/nix-os"; };
    };
  };

  programs.git = {
    enable = true;
    userName = "Adrian";
    # userEmail = "you@example.com";
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      btw = "echo i use nixos, btw";
      ls  = "eza";
      ll  = "eza -l";
      la  = "eza -la";
      cat = "bat";
    };
  };

  # ── Module toggles ──────────────────────────────────────────────────────
  neovim.enable      = true;
  emacs.enable       = true;
  yazi.enable        = true;
  lf.enable          = true;
  ttsConfig.enable   = true;
  firefox.enable     = true;
  thorium.enable     = true;
  qbittorrent.enable = true;
  discord.enable     = true;
  obs.enable         = true;
  # ────────────────────────────────────────────────────────────────────────
}
