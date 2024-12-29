{ pkgs, ... }:
let
  tmpDir = "/var/tmp/nixos-rebuild";
  nixosScripts = pkgs.callPackage ./scripts { inherit tmpDir; };
in
pkgs.mkShell {
  buildInputs =
    [
      pkgs.alejandra
      pkgs.jq
      pkgs.nh
      pkgs.nix-info
      pkgs.nix-output-monitor
      pkgs.nix-template
      pkgs.nix-tree
      pkgs.nix-update
      pkgs.nixpkgs-fmt
      pkgs.nixpkgs-review
      pkgs.node2nix
      pkgs.nvd
    ]
    ++ nixosScripts;

  # To get this to work with direnv you need to add `eval "$shellHook"` to `.envrc`
  shellHook = ''
    [ ! -d ${tmpDir} ] && mkdir -p ${tmpDir}
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
