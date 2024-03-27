{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.pipewire;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.pipewire = {
    enable = mkEnableOption "pipewire";
  };

  config = mkIf cfg.enable {
    sound.enable = true;
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      jack.enable = true;
      pulse.enable = true;
    };
  };
}
