{
  config,
  lib,
  options,
  ...
}: let
  inherit (lib) mkOption types;

  netdevice = types.submodule {
    options.device = mkOption {
      type = types.str;
      default = "";
    };
    options.mac = mkOption {
      type = types.str;
      default = "";
    };
    options.ipv4 = mkOption {
      type = types.str;
      default = "";
    };
    options.ipv4method = mkOption {
      type = types.enum ["static" "dhcpstatic" "dhcp" "pppoe"];
      default = "";
    };
  };

  host = types.submodule ({name, ...}: {
    options.name = mkOption {
      type = types.str;
      default = name;
    };
    options.description = mkOption {
      type = types.str;
      default = "";
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
      default = "";
    };
    options.netmask = mkOption {
      type = types.str;
      default = "";
    };
    options.broadcast = mkOption {
      type = types.str;
      default = "";
    };
  };

  service = types.submodule ({name}: {
    options.hostName = mkOption {
      type = types.str;
      default = name;
    };
    options.domainName = mkOption {
      type = types.str;
      default = options.looniversity.network.domainName.default;
    };
    options.addToDns = mkOption {
      type = types.bool;
      default = false;
    };
    options.addToProxy = mkOption {
      type = types.bool;
      default = false;
    };
    options.handlerName = mkOption {
      type = types.str;
    };
  });

  serviceHandler = types.submodule {
    options.host = mkOption {
      type = types.str;
      default = "";
    };
    options.port = mkOption {
      type = types.int;
      default = -1;
    };
    options.ports = mkOption {
      type = types.attrsOf types.int;
      default = {};
    };
    options.config = mkOption {
      type = types.attrsOf types.anything;
      default = {};
    };
  };
in {
  options.looniversity.network = {
    network = mkOption {
      type = types.str;
      default = "192.168.0.0";
    };

    prefixLength = mkOption {
      type = types.int;
      default = 24;
    };

    domainName = mkOption {
      type = types.str;
      default = "network.arpa";
    };

    ldapRoot = mkOption {
      type = types.str;
      default = "";
    };

    nameServer = mkOption {
      type = types.str;
      default = "";
    };

    hosts = mkOption {
      type = types.attrsOf host;
      default = {};
    };

    services = mkOption {
      type = types.attrsOf service;
      default = {};
    };

    serviceHandlers = mkOption {
      type = types.attrsOf serviceHandler;
      default = {};
    };

    vlans = mkOption {
      type = types.attrsOf vlan;
      default = {};
    };
  };
}
