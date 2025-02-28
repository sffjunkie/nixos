{
  imports = [
    ../../module/user
    ../../role/user
    ../../option
    ../../../setting
  ];

  config = {
    nixpkgs.config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };
}
