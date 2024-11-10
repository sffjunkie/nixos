{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.system.ssh;
  inherit (lib) mkEnableOption mkIf mkOption types traceVal;
in {
  options.looniversity.system.ssh = {
    enable = mkEnableOption "ssh";
    askPassword = mkOption {
      type = types.str;
      default = "1";
    };
  };

  config = mkIf cfg.enable {
    programs.ssh = {
      # startAgent = true;
      enableAskPassword = true;
      askPassword = "${pkgs.lxqt.lxqt-openssh-askpass}/bin/lxqt-openssh-askpass";
    };
  };
}
