{lib, ...}: let
  network = import ../network.nix;

  testConfig = {
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
in {
  testGetHandlerNameForService = {
    expr = lib.network.serviceHandlerNameForService "ca";
    expected = "step-ca";
  };
}
