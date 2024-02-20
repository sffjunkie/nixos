{
  inputs,
  lib,
  config,
  pkgs,
  sops-nix,
  ...
}: {
  imports = [
    ./boot.nix
    ./fs.nix
    ./hardware.nix
    ./networking.nix

    ../common
    ../../module/machine
    ../../module/mount

    ../../role/machine

    sops-nix.nixosModules.sops
  ];

  config = {
    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

    looniversity = {
      service = {
        graylog = {
          enable = true;
          extraConfig = "http_bind_address = 127.0.0.1:9011";
          elasticsearchHosts = ["http://localhost:9200"];
        };
        mongodb.enable = true;
        nextcloud.enable = true;
        postgresql.enable = true;
      };

      role = {
        server.enable = true;
        vm_host.enable = true;
      };
    };

    sops = {
      defaultSopsFile = ../../secret/secrets.yaml;
      defaultSopsFormat = "yaml";
    };

    system.stateVersion = "23.05"; # Did you read the comment?
  };
}
