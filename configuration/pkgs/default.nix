{
  pkgs,
  lib ? pkgs.lib,
  debug ? false,
}:
with lib; let
  pkgsFolder = ./pkgs;
in
  mapAttrs' (name: type: {
    name = removeSuffix ".nix" name;
    value = (
      let
        file = pkgsFolder + "/${name}";
      in
        lib.callPackageWith (pkgs
          // {
            inherit debug;
          })
        file
        {}
    );
  })
  (filterAttrs
    (
      name: type:
        (type == "directory" && builtins.pathExists "${toString pkgsFolder}/${name}/default.nix")
        || (type == "regular" && hasSuffix ".nix" name)
    )
    (builtins.readDir pkgsFolder))
