{
  config,
  lib,
  pkgs,
  ...
}: let
  nixosScriptGenerations = pkgs.callPackage ./generations.nix {};
  nixosScriptInstaller = pkgs.callPackage ./installer.nix {};
  nixosScriptSystem = pkgs.callPackage ./system.nix {};
  nixosScriptVm = pkgs.callPackage ./vm.nix {};
in [
  nixosScriptGenerations
  nixosScriptInstaller
  nixosScriptSystem
  nixosScriptVm
]
