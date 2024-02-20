{
  config,
  lib,
  ...
}: let
  cfg = config.looniversity.role.games_machine;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.role.games_machine = {
    enable = mkEnableOption "games machine role";
  };

  config = mkIf cfg.enable {
    looniversity = {
      steam.enable = true;
      lutris.enable = true;
      pipewire.enable = true;
      retroarch.enable = true;
      role.xserver.enable = true;

      mount = {
        roms.enable = false;
      };
    };
  };
}
