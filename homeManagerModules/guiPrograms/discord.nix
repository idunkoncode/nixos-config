{ lib, config, pkgs, ... }:

let cfg = config.discord; in

{
  options.discord.enable = lib.mkEnableOption "Vesktop (Discord client with Vencord)";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      # Open-source Discord client — screen share with audio works on Wayland/PipeWire.
      # Swap for `discord` if you need the official client.
      vesktop
    ];
  };
}
