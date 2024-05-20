{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./boot.nix
    ./backup.nix
    ./fs.nix
    ./hardware.nix
    ./networking.nix

    ./settings

    ../common
  ];

  config = {
    nixpkgs = {
      hostPlatform = lib.mkDefault "x86_64-linux";
    };

    looniversity = {
      network = {
        net-tools.enable = true;
      };

      system = {
        rclone.enable = true;
      };

      media = {
        pavucontrol.enable = true;
        spotify.enable = true;
      };

      doc = {
        mystmd.enable = true;
      };

      admin = {
        mongodb.enable = true;
        postgresql.enable = true;
      };

      development = {
        devenv.enable = true;
      };

      mount = {
        backup.enable = true;
        music.enable = true;
      };

      script.wake.enable = true;

      role = {
        container_host.enable = true;
        games_machine.enable = true;
        podcaster.enable = true;
        vm_host.enable = true;
        workstation.enable = true;
      };

      shell.zsh.enable = true;

      theme = {
        nord.enable = true;
        papirus.enable = true;
        stylix.enable = true;
      };

      wayland = {
        keyboard.evdevremapkeys.enable = false;
      };
    };

    environment.systemPackages = [
      pkgs.teams-for-linux
      pkgs.zoom-us
    ];

    services.input-remapper.enable = true;

    systemd.services = {
      "rclone@gdrive" = {
        wantedBy = ["default.target"];
      };
      "rclone@onedrive" = {
        wantedBy = ["default.target"];
      };
    };

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };

    environment.localBinInPath = true;

    system.stateVersion = "23.05"; # Did you read the comment?
  };
}
