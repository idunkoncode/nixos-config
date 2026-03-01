{ lib, config, ... }:

let cfg = config.sshServer; in

{
  options.sshServer.enable = lib.mkEnableOption "OpenSSH daemon + CUPS printing";

  config = lib.mkIf cfg.enable {
    services.openssh.enable = true;
    services.printing.enable = true;
  };
}
