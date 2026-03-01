{ lib, config, ... }:

let cfg = config.jellyfinServer; in

{
  options.jellyfinServer.enable = lib.mkEnableOption "Jellyfin media server";

  config = lib.mkIf cfg.enable {
    services.jellyfin = {
      enable = true;
      openFirewall = true;
    };

    users.users.jellyfin.extraGroups = [ "video" "render" ];
  };
}
