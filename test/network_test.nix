{lib, ...}: let
  testConfig = {
    looniversity.network = {
      network = "10.44.0.0";
      prefixLength = 21;
      domainName = "looniversity.net";

      services = {
        ca.handler = "step-ca";
        cloud.handler = "nextcloud";
      };

      serviceHandlers = {
        nextcloud = {
          host = "thebrain";
        };

        step-ca = {
          host = "pinky";
        };
      };
    };
  };
in [
  {
    name = "network.serviceServiceHandlerName";
    actual = lib.network.serviceServiceHandlerName testConfig "ca";
    expected = "step-ca";
  }
]
