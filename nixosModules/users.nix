{ ... }:

{
  users.users.itsthicc = {
    isNormalUser = true;
    description = "Adrian";
    extraGroups = [ "networkmanager" "wheel" "audio" "video" ];
  };

  nixpkgs.config.allowUnfree = true;

  # Start ssh-agent as a systemd user service so keys persist across the session
  programs.ssh.startAgent = true;
}
