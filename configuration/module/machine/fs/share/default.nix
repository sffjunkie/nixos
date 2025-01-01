{
  config,
  lib,
  ...
}:
let
  shares = {
    music = {
      path = "/tank0/music";
      comment = "Music";
    };
  };
  shareOpts = {
    "read only" = true;
    browseable = "yes";
    "guest ok" = "yes";
  };
  samba = config.looniversity.storage.samba;
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    types
    ;
in
{
  config = mkIf samba.enable {
    services.samba.settings.shares = builtins.mapAttrs (name: share: share // shareOpts) cfg.shares;
  };
}
