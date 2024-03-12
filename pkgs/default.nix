{pkgs, ...}: {
  trino = pkgs.callPackage ./trino.nix {};
}
