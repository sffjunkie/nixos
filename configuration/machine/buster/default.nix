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
    # Added for Obsidian
    nixpkgs = {
      hostPlatform = lib.mkDefault "x86_64-linux";

      config.permittedInsecurePackages = [
        "electron-25.9.0"
      ];
    };

    looniversity = {
      spotify.enable = true;
      role.laptop.enable = true;
    };

    sops.defaultSopsFile = ../../secret/secrets.yaml;
    sops.defaultSopsFormat = "yaml";

    programs.zsh = {
      enable = true;
      loginShellInit = ''
        # do not glob # (conflicts with nix flakes)
        disable -p '#'
      '';
    };

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };

    environment.localBinInPath = true;

    system.stateVersion = "23.05";
  };
}
