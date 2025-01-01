{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.looniversity.fs.nfs;
  nfsExport = types.submodule {
    options = {
      path = mkOption {
        type = types.str;
        description = lib.mdDoc ''
          Path to export
        '';
      };
      clients = mkOption {
        type = types.str;
        default = "";
        description = lib.mdDoc ''
          Clients allowed to mount export
        '';
      };
      opts = mkOption {
        type = types.listOf types.str;
        default = [ ];
        description = lib.mdDoc ''
          Export options
        '';
      };
    };
  };
  inherit (lib) mkIf mkOption types;
in
{
  options.looniversity.fs.nfs = {
    exports = mkOption {
      type = types.listOf nfsExport;
      default = [ ];
      description = lib.mdDoc ''
        List of exports
      '';
    };
    clients = mkOption {
      type = types.str;
      default = "";
      description = lib.mdDoc ''
        Default clients allowed to mount export
      '';
    };
    opts = mkOption {
      type = types.listOf types.str;
      default = [ ];
      description = lib.mdDoc ''
        Default export options
      '';
    };
  };

  config =
    mkIf config.looniversity.fs.nfs.exports != [ ] {
      services.nfs.server = {
        exports = lib.concatMapStringsSep "\n" (
          share:
          let
            clients = if share.clients != "" then share.clients else cfg.clients;
            opts = if share.opts != [ ] then share.opts else cfg.opts;
          in
          "${share} ${clients}(${opts})"
        ) config.looniversity.fs.nfs.exports;
      };
    };
}
