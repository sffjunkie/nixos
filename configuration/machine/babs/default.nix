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

    ./services

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
        minio.enable = true;
        nfs.enable = true;
        samba = {
          enable = true;
          shares = {
            music = {
              path = "/tank0/music";
              "read only" = true;
              browseable = "yes";
              "guest ok" = "yes";
              comment = "Music";
            };
          };
        };
        sshd.enable = true;
      };

      role = {
        server.enable = true;
      };
    };

    sops = {
      defaultSopsFile = ../../secret/secrets.yaml;
      defaultSopsFormat = "yaml";
    };

    system.stateVersion = "23.05"; # Did you read the comment?
  };
}
