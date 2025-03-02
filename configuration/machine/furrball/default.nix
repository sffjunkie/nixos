{
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) enabled;
in
{
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
      admin = {
        mongodb.enable = true;
        postgresql.enable = true;
      };

      doc = {
        mystmd.enable = true;
      };

      media = {
        pavucontrol.enable = true;
        spotify.enable = true;
      };

      mount = {
        backup.enable = true;
        movies.enable = true;
        music.enable = true;
        private.enable = true;
      };

      network = {
        net-tools.enable = true;
      };

      role = {
        container_host.enable = true;
        games_machine.enable = true;
        podcaster.enable = true;
        vm_host.enable = true;
        workstation.enable = true;
      };

      script.wake.enable = true;

      service = {
        immich = enabled;
      };

      shell.zsh.enable = true;

      storage.udisks2.enable = true;

      system = {
        rclone.enable = true;
        # ssh.enable = true;
      };

      theme = {
        stylix.enable = true;
      };
    };

    environment.systemPackages = [
      pkgs.teams-for-linux
      pkgs.zoom-us
    ];

    services.input-remapper.enable = true;

    systemd.services = {
      "rclone@gdrive" = {
        wantedBy = [ "default.target" ];
      };
      "rclone@onedrive" = {
        wantedBy = [ "default.target" ];
      };
    };

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };

    environment.localBinInPath = true;

    system.stateVersion = "23.05"; # Did you read the comment?
  };
}
