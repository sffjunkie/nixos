{pkgs, ...}:
pkgs.mkShell {
  nativeBuildInputs = [
    pkgs.buildPackages.go_1_20
  ];
}
