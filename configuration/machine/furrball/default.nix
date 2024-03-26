{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./boot.nix
    ./backup.nix
    ./fs.nix
    ./hardware.nix
    ./networking.nix

    ../common
  ];

  config = {
    nixpkgs = {
      hostPlatform = lib.mkDefault "x86_64-linux";

      # Added for Obsidian
      config.permittedInsecurePackages = [
        "electron-25.9.0"
      ];
    };

    looniversity = {
      net-tools.enable = true;
      rclone.enable = true;
      spotify.enable = true;

      mystmd.enable = true;

      admin = {
        mongodb.enable = true;
        postgresql.enable = true;
      };

      mount = {
        backup.enable = true;
        music.enable = true;
      };

      script.wake.enable = true;

      role = {
        # TODO: Remove when testing complete
        log_server.enable = true;

        container_host.enable = true;
        games_machine.enable = true;
        podcaster.enable = true;
        vm_host.enable = true;
        workstation.enable = true;
        xserver.enable = true;
      };

      theme = {
        nord.enable = true;
        papirus.enable = true;
      };
    };

    environment.systemPackages = [
      pkgs.teams-for-linux
      pkgs.zoom-us
    ];

    systemd.services = {
      "rclone@gdrive" = {
        wantedBy = ["default.target"];
      };
      "rclone@onedrive" = {
        wantedBy = ["default.target"];
      };
    };

    programs.zsh.enable = true;

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };

    environment.localBinInPath = true;

    system.stateVersion = "23.05"; # Did you read the comment?
  };
}
