{ lib, config, pkgs, inputs, ... }:

let cfg = config.neovim; in

{
  imports = [ inputs.nix4nvchad.homeManagerModule ];

  options.neovim.enable = lib.mkEnableOption "NvChad (neovim distribution)";

  config = lib.mkIf cfg.enable {
    programs.nvchad = {
      enable = true;

      # Language servers and tools available to NvChad
      extraPackages = with pkgs; [
        nixd              # Nix LSP
        lua-language-server
        nodePackages.bash-language-server
        rust-analyzer
        pyright
        clang-tools       # clangd
      ];

      hm-activation = true;  # let home-manager manage the config
      backup = true;
    };
  };
}
