{pkgs, ...}: let
  nixosScripts = pkgs.callPackage ./scripts {};
in
  pkgs.mkShell {
    buildInputs =
      [
        pkgs.alejandra
        pkgs.nix-info
        pkgs.nix-template
        pkgs.nix-tree
        pkgs.nix-update
        pkgs.nixpkgs-fmt
        pkgs.nixpkgs-review
        pkgs.node2nix
      ]
      ++ nixosScripts;
  }
