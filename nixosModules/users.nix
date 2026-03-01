{ ... }:

{
  users.users.itsthicc = {
    isNormalUser = true;
    description = "Adrian";
    extraGroups = [ "networkmanager" "wheel" "audio" "video" ];
  };

  nixpkgs.config.allowUnfree = true;
}
