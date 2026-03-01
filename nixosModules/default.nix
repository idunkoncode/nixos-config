{ ... }:

{
  imports = [
    ./desktop.nix
    ./audio.nix
    ./users.nix
    ./locale.nix
    ./programs/common.nix
    ./programs/shells.nix
    ./programs/dev.nix
    ./programs/gaming.nix
    ./services/openssh.nix
    ./services/jellyfin.nix
    ./services/tts.nix
    ./stylix.nix
  ];
}
