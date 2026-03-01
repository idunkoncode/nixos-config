{ lib, config, ... }:

let cfg = config.yazi; in

{
  options.yazi.enable = lib.mkEnableOption "yazi file manager";

  config = lib.mkIf cfg.enable {
    programs.yazi = {
      enable = true;
      enableBashIntegration = true;

      settings = {
        manager = {
          show_hidden = true;
          show_symlink = true;
          sort_by = "natural";
          sort_dir_first = true;
        };

        preview = {
          tab_size = 2;
          max_width = 600;
          max_height = 900;
        };
      };
    };
  };
}
