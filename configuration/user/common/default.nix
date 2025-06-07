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
    nixpkgs.config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };
}
