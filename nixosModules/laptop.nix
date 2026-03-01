{ lib, config, ... }:

let cfg = config.laptop; in

{
  options.laptop.enable = lib.mkEnableOption "laptop-specific config (TLP, touchpad, backlight, bluetooth)";

  config = lib.mkIf cfg.enable {
    services.libinput.enable = true;

    services.tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        START_CHARGE_THRESH_BAT0 = 20;
        STOP_CHARGE_THRESH_BAT0 = 80;
      };
    };
    services.power-profiles-daemon.enable = lib.mkForce false;

    programs.light.enable = true;

    hardware.bluetooth = {
      enable = true;
      powerOnBoot = false;
    };
    services.blueman.enable = true;

    services.thermald.enable = true;
  };
}
