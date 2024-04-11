{
  config,
  lib,
  ...
}: let
  cfg = config.looniversity.storage.samba;
  inherit (lib) mkEnableOption mkIf mkOption types;
in {
  options = {
    looniversity.storage.samba = {
      enable = mkEnableOption "samba";

      shares = mkOption {
        default = {};
        description = lib.mdDoc ''
          A set describing shared resources.
          See {command}`man smb.conf` for options.
        '';
        type = types.attrsOf (types.attrsOf types.unspecified);
        example = types.literalExpression ''
          { public =
            { path = "/srv/public";
              "read only" = true;
              browseable = "yes";
              "guest ok" = "yes";
              comment = "Public samba share.";
            };
          }
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    services.samba = {
      enable = true;
      enableNmbd = false;
      enableWinbindd = false;
      openFirewall = true;
      securityType = "user";
      extraConfig = ''
        client max protocol = SMB3
        client min protocol = SMB2
        guest account = nobody
        hosts allow = 10.44. 127.0.0.1 ::1
        hosts deny = 0.0.0.0/0
        map to guest = bad user
        server string = samba
        workgroup = LOONIVERSITY
      '';
      shares = config.looniversity.service.samba.shares;
    };

    services.samba-wsdd.enable = true;
  };
}
