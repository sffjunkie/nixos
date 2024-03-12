{pkgs, ...}: {
  environment.systemPackages = [
    # (pkgs.callPackage ./trino.nix {})
  ];
}
