{
  config,
  lib,
  pkgs,
  ...
}: {
  config = {
    services.kea = {
      dhcp4 = {
        enable = true;

        settings = {
          authoritative = true;
          valid-lifetime = 7200;
          max-valid-lifetime = 86400;

          lease-database = {
            type = "memfile";
            persist = true;
            name = "/var/lib/kea/dhcp4.leases";
          };

          option-data = [
            {
              name = "domain-name";
              data = config.looniversity.network.domainName;
            }
            {
              name = "domain-name-servers";
              data = [
                config.looniversity.network.nameServer
                "8.8.8.8"
                "1.1.1.1"
              ];
            }
            {
              name = "routers";
              data = "10.44.0.1";
            }
          ];

          hooks-libraries = [
            {
              library = "/usr/local/lib/kea/hooks/libdhcp_lease_cmds.so";
            }
          ];

          subnet4 = [
            {
              id = 1;
              subnet = lib.concatStringsSep "/" [
                "${config.looniversity.network.network}"
                "${toString config.looniversity.network.prefixLength}"
              ];
              pools = [
                {pool = "10.44.0.101 - 10.44.0.149";}
              ];

              reservations = [
                {
                  hostname = "sw1";
                  hw-address = "10:da:43:d9:d9:d1";
                  ip-address = "10.44.0.2";
                }
              ];
            }
            {
              id = 10;
              subnet = "10.44.20.0/24";
              pools = [
                {pool = "10.44.10.101 - 10.44.10.199";}
              ];
            }
            {
              id = 20;
              subnet = "10.44.20.0/24";
              pools = [
                {pool = "10.44.20.101 - 10.44.20.199";}
              ];
            }
            {
              id = 30;
              subnet = "10.44.30.0/24";
              pools = [
                {pool = "10.44.30.101 - 10.44.30.199";}
              ];
            }
          ];
        };
      };
    };
  };
}
