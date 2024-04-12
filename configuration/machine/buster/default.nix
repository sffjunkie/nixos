{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./boot.nix
    ./fs.nix
    ./hardware.nix
    ./networking.nix

    ../common
  ];

  config = {
    # Added for Obsidian
    nixpkgs = {
      hostPlatform = lib.mkDefault "x86_64-linux";

      # config.permittedInsecurePackages = [
      #   "electron-25.9.0"
      # ];
    };

    looniversity = {
      media = {
        spotify.enable = true;
      };
      # TODO: Disable until secrets added to Sops
      network = {
        openvpn.enable = false;
      };

      role = {
        laptop.enable = true;
        vm_host.enable = true;
      };

      shell.zsh.enable = true;

      theme = {
        nord.enable = true;
        papirus.enable = true;
      };
    };

    environment.systemPackages = [
      pkgs.teams-for-linux
      pkgs.zoom-us
    ];

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };

    environment.localBinInPath = true;

    system.stateVersion = "23.05";
  };
}
