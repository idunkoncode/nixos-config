# Desktop: ASUS X870E-H | Ryzen 9 9950X | RX 9070 XT | 32GB RAM | 2TB

{ pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos-desktop";
  networking.networkmanager.enable = true;

  # AMD Ryzen 9 9950X
  hardware.cpu.amd.updateMicrocode = true;

  # AMD RX 9070 XT (RDNA 4)
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  services.xserver.videoDrivers = [ "amdgpu" ];

  hardware.enableRedistributableFirmware = true;

  # ── Module toggles ────────────────────────────────────────────────────────
  desktop.enable        = true;
  audio.enable          = true;
  commonPackages.enable = true;
  extraShells.enable    = true;
  devPackages.enable    = true;
  gaming.enable         = true;
  sshServer.enable      = true;
  jellyfinServer.enable = true;
  ttsEngine.enable      = true;
  stylixTheme.enable    = true;
  stylixTheme.theme     = "catppuccin";
  # laptop.enable       = false;  # desktop — leave off
  # ─────────────────────────────────────────────────────────────────────────

  system.stateVersion = "25.11";
}
