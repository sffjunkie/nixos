{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf mkOption types;
in
{
  config =
    mkIf config.looniversity.fs.nfs.exports != [ ] {
      services.nfs = {
        server = {
          enable = true;
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

      networking.firewall.allowedTCPPorts = [
        111
        2049
        4000
        4001
        4002
      ];
      networking.firewall.allowedUDPPorts = [
        111
        2049
        4000
        4001
        4002
      ];
    };
}
