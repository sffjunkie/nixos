{lib, ...}: let
  testData = {
    config = {
      looniversity.network = {
        network = "192.168.1.0";
        prefixLength = 21;
        domainName = "lan.internal";

        hosts = {
          hosta = {
            netdevice = {
              lan = {
                device = "eth0";
                ipv4 = "192.168.1.1";
                ipv4method = "dhcpstatic";
                mac = "48:d6:32:db:83:de";
              };
            };
          };
        };

        services = {
          ca.handler = "step-ca";
          cloud.handler = "nextcloud";
        };

        serviceHandlers = {
          nextcloud = {
            host = "cloud";
            port = 80;
          };

          step-ca = {
            host = "bigbox";
            ports = {
              ui = 8080;
            };
          };
        };
      };
    };
  };
in [
  {
    name = "network.netdevice";
    actual = lib.network.netdevice testData.config "hosta" "lan";
    expected = "eth0";
  }
  {
    name = "network.lanIpv4";
    actual = lib.network.lanIpv4 testData.config "hosta";
    expected = "192.168.1.1";
  }
  {
    name = "network.serviceHandler";
    actual = (lib.network.serviceHandler testData.config "nextcloud").host;
    expected = "cloud";
  }
  {
    name = "network.serviceHandlerMainPort";
    actual = lib.network.serviceHandlerMainPort testData.config "nextcloud";
    expected = 80;
  }
  {
    name = "network.serviceHandlerNamedPort";
    actual = lib.network.serviceHandlerNamedPort testData.config "step-ca" "ui";
    expected = 8080;
  }
  {
    name = "network.serviceHandlerHostName";
    actual = lib.network.serviceHandlerHostName testData.config "step-ca";
    expected = "bigbox";
  }
  {
    name = "network.serviceHandlerFQDN";
    actual = lib.network.serviceHandlerFQDN testData.config "step-ca";
    expected = "bigbox.lan.internal";
  }
  # {
  #   skip = "Need to find out how config values are linked to options";
  #   name = "network.serviceHostName";
  #   actual = lib.network.serviceHostName testData.config "ca";
  #   expected = "ca";
  # }
  {
    name = "network.serviceServiceHandlerName";
    actual = lib.network.serviceServiceHandlerName testData.config "ca";
    expected = "step-ca";
  }
]
