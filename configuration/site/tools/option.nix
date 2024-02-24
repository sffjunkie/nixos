{
  config,
  lib,
  ...
}: let
  tool = types.submodule ({name, ...}: {
    options = {
      name = mkOption {
        type = types.str;
        default = name;
      };
      module = mkOption {
        type = types.str;
        default = "";
      };
      port = mkOption {
        type = types.int;
        default = -1;
      };
    };
  });

  inherit (lib) mkOption types;
in {
  options.looniversity.tools = {
    type = types.attrsOf tool;
    default = {};
  };
}
