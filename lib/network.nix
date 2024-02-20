{lib, ...}: let
  # getNetdevice :: attrSet -> str -> str -> str
  # Gets a hosts network device given an alias
  getNetdevice = config: host: ifname: config.looniversity.network.hosts.${host}.netdevice.${ifname}.device;

  # getLanIpv4 :: attrSet -> str -> str
  getLanIpv4 = config: host: config.looniversity.network.hosts.${host}.netdevice.lan.ipv4;

  # handlerName -> ...

  # getHandler :: attrSet -> str -> attrSet
  getHandler = config: handlerName: config.looniversity.network.serviceHandlers.${handlerName};

  # getHandlerHostName :: attrSet -> str -> str
  getHandlerHostName = config: handlerName: config.looniversity.network.serviceHandlers.${handlerName}.host;

  # getHandlerHostFQDN :: attrSet -> str -> str
  getHandlerHostFQDN = config: handlerName:
    lib.concatStringsSep "."
    [(getHandlerHostName config handlerName) config.looniversity.network.domainName];

  # getHandlerNamedPort :: attrSet -> str -> str -> int
  getHandlerNamedPort = config: handlerName: portName: config.looniversity.network.serviceHandlers.${handlerName}.ports.${portName};

  # serviceName -> ...

  # getHandlerNameForService :: attrSet -> str -> str
  getHandlerNameForService = config: serviceName: config.looniversity.network.services.${serviceName}.handler;

  # getHandlerForService :: attrSet -> str -> attrSet
  getHandlerForService = config: serviceName: getHandler config (getHandlerNameForService config serviceName);

  # getHandlerHostNameForService :: attrSet -> str -> str
  getHandlerHostNameForService = config: serviceName: (getHandlerForService config serviceName).host;

  # getHandlerHostFQDNForService :: attrSet -> str -> str
  getHandlerHostFQDNForService = config: serviceName:
    lib.concatStringsSep "/"
    [(getHandlerHostNameForService config serviceName) config.looniversity.network.domainName];
in {
  inherit getNetdevice getLanIpv4;
  inherit getHandler getHandlerHostName getHandlerHostFQDN;
  inherit getHandlerNamedPort;
  inherit getHandlerNameForService getHandlerForService;
  inherit getHandlerHostNameForService getHandlerHostFQDNForService;
}
