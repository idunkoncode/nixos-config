{ lib, config, pkgs, inputs, ... }:

let
  cfg = config.stylixTheme;

  themes = {
    catppuccin = {
      scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
      image  = "${inputs.catppuccin-wallpapers}/minimalistic/catppuccin_triangle.png";
    };
    gruvbox = {
      scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
      image  = "${inputs.catppuccin-wallpapers}/minimalistic/dark-cat.png";
    };
    tokyo = {
      scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
      image  = "${inputs.catppuccin-wallpapers}/minimalistic/blue-cat.png";
    };
  };

  selected = themes.${cfg.theme};
in

{
  options.stylixTheme = {
    enable = lib.mkEnableOption "Stylix system-wide theming";

    theme = lib.mkOption {
      type    = lib.types.enum [ "catppuccin" "gruvbox" "tokyo" ];
      default = "catppuccin";
      description = "Color scheme to apply system-wide (catppuccin | gruvbox | tokyo).";
    };
  };

  config = lib.mkIf cfg.enable {
    stylix = {
      enable   = true;
      polarity = "dark";

      base16Scheme = selected.scheme;
      image        = selected.image;

      fonts = {
        monospace = {
          package = pkgs.nerd-fonts.terminess-ttf;
          name    = "TerminessTTF Nerd Font Mono";
        };
        sansSerif = {
          package = pkgs.noto-fonts;
          name    = "Noto Sans";
        };
        serif = {
          package = pkgs.noto-fonts;
          name    = "Noto Serif";
        };
        emoji = {
          package = pkgs.noto-fonts-color-emoji;
          name    = "Noto Color Emoji";
        };
        sizes = {
          terminal     = 13;
          applications = 12;
          desktop      = 12;
          popups       = 12;
        };
      };

      # NvChad and Doom Emacs manage their own themes
      targets.neovim.enable = false;
      targets.emacs.enable  = false;
    };
  };
}
