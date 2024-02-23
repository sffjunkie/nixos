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

      mount = {
        music.enable = true;
      };

      script.wake.enable = true;

      role = {
        container_host.enable = true;
        games_machine.enable = true;
        vm_host.enable = true;
        workstation.enable = true;
        xserver.enable = true;
      };
    };

    sops = {
      defaultSopsFile = ../../secret/secrets.yaml;
      defaultSopsFormat = "yaml";
    };

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
