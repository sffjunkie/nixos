{lib, ...}: let
  network_tests = (import ./network_test.nix) {inherit lib;};
in
  lib.runTests network_tests
