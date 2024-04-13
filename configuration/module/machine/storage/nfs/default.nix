{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.storage.nfs;
  inherit (lib) mkEnableOption mkIf mkOption types;
in {
  options.looniversity.storage.nfs = {
    enable = mkEnableOption "nfs";

    exports = mkOption {
      type = types.listOf types.str;
      default = [];
      description = lib.mdDoc ''
        A list of NFS exports
      '';
    };
  };

  config = mkIf cfg.enable {
    services.nfs = {
      server = {
        enable = true;
        exports =
          lib.concatMapStringsSep
          "\n"
          (share: "${share} ${config.looniversity.network.network}/${toString config.looniversity.network.prefixLength}(rw,no_subtree_check)")
          config.looniversity.storage.nfs.exports;

        statdPort = 4000;
        lockdPort = 4001;
        mountdPort = 4002;
      };

      settings = {
        nfsd.rdma = true; # Remote Direct Memory Access
        nfsd.vers3 = false;
        nfsd.vers4 = true;
        nfsd."vers4.0" = false;
        nfsd."vers4.1" = false;
        nfsd."vers4.2" = true;
      };
    };

    networking.firewall.allowedTCPPorts = [111 2049 4000 4001 4002];
    networking.firewall.allowedUDPPorts = [111 2049 4000 4001 4002];
  };
}
