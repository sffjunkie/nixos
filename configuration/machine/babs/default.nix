{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./backup.nix
    ./boot.nix
    ./fs.nix
    ./hardware.nix
    ./networking.nix
    ./services

    ../common
  ];

  config = {
    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

    looniversity = {
      net-tools.enable = true;
      service = {
        minio = {
          enable = true;
          dataDir = ["/tank0/minio/data"];
        };
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

    system.stateVersion = "23.05"; # Did you read the comment?
  };
}
