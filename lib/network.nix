{lib, ...}: let
  # getNetdevice :: attrSet -> str -> str -> str
  # Gets a hosts network device given an alias
  getNetdevice = config: host: ifname: config.looniversity.network.hosts.${host}.netdevice.${ifname}.device;

  # getLanIpv4 :: attrSet -> str -> str
  getLanIpv4 = config: host: config.looniversity.network.hosts.${host}.netdevice.lan.ipv4;

  # handlerName -> ...

  # serviceHandler :: attrSet -> str -> attrSet
  serviceHandler = config: handlerName: config.looniversity.network.serviceHandlers.${handlerName};

  # serviceHandlerHostName :: attrSet -> str -> str
  serviceHandlerHostName = config: handlerName: config.looniversity.network.serviceHandlers.${handlerName}.host;

  # serviceHandlerHostFQDN :: attrSet -> str -> str
  serviceHandlerHostFQDN = config: handlerName:
    lib.concatStringsSep "."
    [(serviceHandlerHostName config handlerName) config.looniversity.network.domainName];

  # serviceHandlerNamedPort :: attrSet -> str -> str -> int
  serviceHandlerNamedPort = config: handlerName: portName: config.looniversity.network.serviceHandlers.${handlerName}.ports.${portName};

  # serviceName -> ...

  # serviceHandlerNameForService :: attrSet -> str -> str
  serviceHandlerNameForService = config: serviceName: config.looniversity.network.services.${serviceName}.handler;

  # serviceHandlerForService :: attrSet -> str -> attrSet
  serviceHandlerForService = config: serviceName: serviceHandler config (serviceHandlerNameForService config serviceName);

  # serviceHandlerHostNameForService :: attrSet -> str -> str
  serviceHandlerHostNameForService = config: serviceName: (serviceHandlerForService config serviceName).host;

  # serviceHandlerHostFQDNForService :: attrSet -> str -> str
  serviceHandlerHostFQDNForService = config: serviceName:
    lib.concatStringsSep "/"
    [(serviceHandlerHostNameForService config serviceName) config.looniversity.network.domainName];
in {
  inherit getNetdevice getLanIpv4;
  inherit serviceHandler serviceHandlerHostName serviceHandlerHostFQDN;
  inherit serviceHandlerNamedPort;
  inherit serviceHandlerNameForService serviceHandlerForService;
  inherit serviceHandlerHostNameForService serviceHandlerHostFQDNForService;
}
