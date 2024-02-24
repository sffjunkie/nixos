{pkgs, ...}: let
  nixosScripts = pkgs.callPackage ./scripts {};
in
  pkgs.mkShell {
    buildInputs =
      [
        pkgs.alejandra
        pkgs.jq
        pkgs.nix-info
        pkgs.nix-template
        pkgs.nix-tree
        pkgs.nix-update
        pkgs.nixpkgs-fmt
        pkgs.nixpkgs-review
        pkgs.node2nix
      ]
      ++ nixosScripts;

    shellHook = ''
      nix-test() {
        $(nix flake show --json | jq -e .tests 2>&1 > /dev/null)
        if [ $? -eq 0 ]; then
          nix eval --raw '.#tests'
        else
          echo "No tests output attribute found"
        fi
      }
    '';
  }
