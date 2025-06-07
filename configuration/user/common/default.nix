{ inputs, ... }:
{
  imports = [
    ../../module/user
    ../../option
    ../../role/user
    ../../secret
    ../../../setting
  ];

  config = {
    sops = {
      defaultSopsFormat = "yaml";
    };

    nixpkgs.config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };
}
