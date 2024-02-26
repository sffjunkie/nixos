{lib, ...}: final: prev: {
  enabled = {enable = true;};
  ipv4 = import ./ipv4.nix {inherit lib;};
  network = import ./network.nix {inherit lib;};
  tool = import ./tool.nix {inherit lib;};
  test = import ./test.nix {inherit lib;};
}
