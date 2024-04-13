{
  config,
  lib,
  ...
}: let
  inherit (lib) mkOption types;
in {
  imports = [
    ./base.nix
  ];
}
