{ config
, lib
, ...
}:
let
  cfg = config.looniversity.storage.udisks2;
  inherit (lib) mkEnableOption mkIf mkOption types;
in
{
  options = {
    looniversity.storage.udisks2 = {
      enable = mkEnableOption "udisks2";
    };
  };

  config = mkIf cfg.enable {
    services.udisks2.enable = true;
  };
}
