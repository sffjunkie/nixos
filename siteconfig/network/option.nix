{
  config,
  lib,
  options,
  ...
}: let
  inherit (lib) mkOption types;

  netdevice = types.submodule {
    options = {
      device = mkOption {
        type = types.str;
        default = "";
      };
      mac = mkOption {
        type = types.str;
        default = "";
      };
      ipv4 = mkOption {
        type = types.str;
        default = "";
      };
      ipv4method = mkOption {
        type = types.enum ["static" "dhcpstatic" "dhcp" "pppoe"];
        default = "";
      };
    };
  };

  host = types.submodule ({name, ...}: {
    options = {
      name = mkOption {
        type = types.str;
        default = name;
      };
      description = mkOption {
        type = types.str;
        default = "";
      };
      netdevice = mkOption {
        type = types.attrsOf netdevice;
        description = "Named network devices";
        default = {};
      };
    };
  });

  dhcp = types.submodule {
    options = {
      start = mkOption {
        type = types.int;
        default = 101;
      };
      end = mkOption {
        type = types.int;
        default = 150;
      };
    };
  };

  vlan = types.submodule {
    options = {
      id = mkOption {
        type = types.int;
      };
      network = mkOption {
        type = types.str;
        default = "";
      };
      prefixLength = mkOption {
        type = types.int;
        default = 24;
      };
      dhcp = mkOption {
        type = types.nullOr dhcp;
      };
    };
  };

  service = types.submodule ({name}: {
    options = {
      hostName = mkOption {
        type = types.str;
        default = name;
      };
      domainName = mkOption {
        type = types.str;
        default = options.looniversity.network.domainName.default;
      };
      addToDns = mkOption {
        type = types.bool;
        default = false;
      };
      addToProxy = mkOption {
        type = types.bool;
        default = false;
      };
      handlerName = mkOption {
        type = types.str;
      };
    };
  });

  serviceHandler = types.submodule {
    options = {
      host = mkOption {
        type = types.str;
        default = "";
      };
      port = mkOption {
        type = types.int;
        default = -1;
      };
      ports = mkOption {
        type = types.attrsOf types.int;
        default = {};
      };
      config = mkOption {
        type = types.attrsOf types.anything;
        default = {};
      };
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
