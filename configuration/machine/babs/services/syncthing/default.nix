{config, ...}: let
  cfg = config.services.syncthing;
in {
  config = {
    services.syncthing = {
      enable = true;
      openDefaultPorts = true;
      guiAddress = "0.0.0.0:8384";

      settings = {
        options = {
          relaysEnabled = false;
        };

        devices = {
          babs = {
            id = "OZVWWSR-TOBJZPP-S6YIHEN-HN3M3Z7-MF4DVVV-O5QBKDB-6KQ73XF-V22RXAW";
            addresses = ["dynamic"];
          };
          furrball = {
            id = "L43XHU2-5TRAIBG-T7JFZXO-4YI6M6Q-3GQJWHE-XR4ZA76-IG35CYM-RTF2GQB";
            addresses = ["dynamic"];
          };
        };

        folders = {
          sdk-development = {
            id = "sdk-development";
            path = "/tank0/sync/sdk/development";
            type = "receiveonly";
            devices = [
              "babs"
              "furrball"
            ];
          };

          sdk-documents = {
            id = "sdk-documents";
            path = "/tank0/sync/sdk/documents";
            type = "receiveonly";
            devices = [
              "babs"
              "furrball"
            ];
          };

          sdk-persona = {
            id = "sdk-persona";
            path = "/tank0/sync/sdk/persona";
            type = "receiveonly";
            devices = [
              "babs"
              "furrball"
            ];
          };

          sdk-pictures = {
            id = "sdk-pictures";
            path = "/tank0/sync/sdk/pictures";
            type = "receiveonly";
            devices = [
              "babs"
              "furrball"
            ];
          };

          site-ebooks = {
            id = "site-ebooks";
            path = "/tank0/sync/site/ebooks";
            devices = [
              "babs"
              "furrball"
            ];
          };
        };
      };
    };
  };
}
