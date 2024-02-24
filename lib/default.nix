{lib, ...}: final: prev: {
  enabled = {enable = true;};
  network = import ./network.nix {inherit lib;};
  tool = import ./network.nix {inherit lib;};
}
