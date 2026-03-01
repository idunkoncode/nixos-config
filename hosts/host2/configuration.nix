# Laptop: ThinkPad X1 Carbon 6th Gen | Intel i7-8650U | Intel UHD 620

{ pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos-laptop";
  networking.networkmanager.enable = true;

  # Intel i7-8650U
  hardware.cpu.intel.updateMicrocode = true;

  # Intel UHD 620
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-compute-runtime
    ];
  };

  hardware.enableRedistributableFirmware = true;

  # ── Module toggles ────────────────────────────────────────────────────────
  desktop.enable        = true;
  audio.enable          = true;
  laptop.enable         = true;   # ThinkPad-specific: TLP, touchpad, backlight
  commonPackages.enable = true;
  extraShells.enable    = true;
  devPackages.enable    = true;
  gaming.enable         = false;  # disabled — X1 Carbon has no dGPU
  sshServer.enable      = true;
  jellyfinServer.enable = false;  # media server lives on the desktop
  ttsEngine.enable      = true;
  stylixTheme.enable    = true;
  stylixTheme.theme     = "catppuccin";
  # ─────────────────────────────────────────────────────────────────────────

  system.stateVersion = "25.11";
}
