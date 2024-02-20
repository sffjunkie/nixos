{
  imports = [
    ./l10n.nix
    ./modules.nix
    ./nix.nix
    ./packages.nix
    ../../site
  ];

  services.fstrim.enable = true;
}
