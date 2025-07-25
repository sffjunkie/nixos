{
  config,
  lib,
  options,
  pkgs,
  isoTarget ? "/run/media/sdk/Ventoy/",
  ...
}:
with lib;
{
  config = {
    nix.settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

    sops = {
      defaultSopsFile = ../configuration/secret/secrets.yaml;
      defaultSopsFormat = "yaml";

      secrets."wifi/ssid" = { };
      secrets."wifi/psk" = { };

      templates."wpa_supplicant".content = ''
        ctrl_interface=/run/wpa_supplicant
        ctrl_interface_group=wheel
        update_config=1
        network = {
            ssid=${config.sops.placeholder."wifi/ssid"}
            psk=${config.sops.placeholder."wifi/psk"}
        }
      '';
    };

    isoImage.isoName = lib.mkForce "looniversity-minimal-${pkgs.stdenv.hostPlatform.system}.iso";

    environment.etc = {
      nixos.source = ../configuration;
      disko.source = ../template/disko;

      "wpa_supplicant.conf".source = config.sops.templates."wpa_supplicant".path;
    };

    environment.systemPackages = with pkgs; [
      age
      gnumake
      just
      ssh-to-age
      sops
      yq
    ];
  };
}
