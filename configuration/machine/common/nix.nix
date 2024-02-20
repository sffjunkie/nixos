{
  config = {
    nix.settings = {
      experimental-features = ["nix-command" "flakes"];
      warn-dirty = false;
    };

    nixpkgs.config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };
}
