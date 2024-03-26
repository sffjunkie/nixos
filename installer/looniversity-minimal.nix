{
  config,
  lib,
  options,
  pkgs,
  isoTarget ? "/run/media/sdk/Ventoy/",
  ...
}:
with lib; {
  config = {
    sops = {
      defaultSopsFile = ../configuration/secret/secrets.yaml;
      defaultSopsFormat = "yaml";
    };

    nix.settings = {
      experimental-features = ["nix-command" "flakes"];
    };

    isoImage.isoName = lib.mkForce "looniversity-minimal-${pkgs.stdenv.hostPlatform.system}.iso";

    environment.etc = {
      configuration.source = ../configuration;
      disko.source = ../disko;
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
