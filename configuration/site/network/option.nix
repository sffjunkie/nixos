{
  config,
  lib,
  ...
}: let
  inherit (lib) mkOption types;

  netdevice = types.submodule {
    options.device = mkOption {
      type = types.str;
    };
    options.mac = mkOption {
      type = types.str;
    };
    options.ipv4 = mkOption {
      type = types.str;
    };
    options.ipv4method = mkOption {
      type = types.enum ["static" "dhcpstatic" "dhcp" "pppoe"];
    };
  };

  host = types.submodule ({name, ...}: {
    options.name = mkOption {
      type = types.str;
      default = name;
    };
    options.network = mkOption {
      type = types.str;
    };
    options.prefixLength = mkOption {
      type = types.int;
    };
    options.description = mkOption {
      type = types.str;
    };
    options.netdevice = mkOption {
      type = types.attrsOf netdevice;
      description = "Named network devices";
      default = {};
    };
  });

  vlan = types.submodule {
    options.id = mkOption {
      type = types.int;
    };
    options.network = mkOption {
      type = types.str;
    };
    options.netmask = mkOption {
      type = types.str;
    };
    options.broadcast = mkOption {
      type = types.str;
    };
  };

  service = types.submodule ({name}: {
    options.hostName = mkOption {
      type = types.str;
      default = name;
    };
    options.domainName = mkOption {
      type = types.str;
      default = "";
    };
    options.addToDns = mkOption {
      type = types.bool;
      default = false;
    };
    options.addToProxy = mkOption {
      type = types.bool;
      default = false;
    };
    options.handler = mkOption {
      type = types.str;
    };
  });

  serviceHandler = types.submodule {
    options.host = mkOption {
      type = types.str;
    };
    options.port = mkOption {
      type = types.int;
    };
    options.ports = mkOption {
      type = types.attrsOf types.int;
      default = {};
    };
    options.config = mkOption {
      type = types.attrsOf types.anything;
    };
  };
in {
  options.looniversity.network = {
    network = mkOption {
      type = types.str;
    };

    prefixLength = mkOption {
      type = types.int;
    };

    domainName = mkOption {
      type = types.str;
    };

    ldapRoot = mkOption {
      type = types.str;
    };

    hosts = mkOption {
      type = types.attrsOf host;
    };

    services = mkOption {
      type = types.attrsOf service;
    };

    serviceHandlers = mkOption {
      type = types.attrsOf serviceHandler;
    };

    vlans = mkOption {
      type = types.attrsOf vlan;
    };
  };
}
