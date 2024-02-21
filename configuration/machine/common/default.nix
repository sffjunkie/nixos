{
  imports = [
    ./l10n.nix
    ./modules.nix
    ./nix.nix
    ./packages.nix
    ./workaround
    ../../site
  ];

  services.fstrim.enable = true;
}
