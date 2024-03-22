{lib, ...}: {
  options.sopsFiles = lib.mkOption {
    type = lib.types.attrsOf lib.types.path;
  };

  config.sopsFiles = {
    default = ./secrets.yaml;
    service = ./service.yaml;
    user = ./user.yaml;
  };
}
