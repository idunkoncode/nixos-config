{ lib, config, ... }:

let cfg = config.lf; in

{
  options.lf.enable = lib.mkEnableOption "lf file manager";

  config = lib.mkIf cfg.enable {
    programs.lf = {
      enable = true;

      settings = {
        preview   = true;
        hidden    = true;
        drawbox   = false;
        icons     = true;
        ignorecase = true;
      };

      keybindings = {
        "<enter>" = "open";
        "."       = "set hidden!";
      };

      extraConfig = ''
        set promptfmt "\033[34;1m%u@%h\033[0m:\033[32m%d\033[0m\033[1m%f\033[0m"
      '';
    };
  };
}
