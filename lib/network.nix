{lib, ...}: let
  # netdevice :: attrSet -> str -> str -> str
  # Gets a hosts network device given an alias
  netdevice = config: host: ifname: config.looniversity.network.hosts.${host}.netdevice.${ifname}.device;

  # lanIpv4 :: attrSet -> str -> str
  lanIpv4 = config: host: config.looniversity.network.hosts.${host}.netdevice.lan.ipv4;

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

  # serviceDomainName :: attrSet -> str -> str
  serviceDomainName = config: serviceName: config.looniversity.network.services.${serviceName}.domainName;

  # serviceServiceHandlerName :: attrSet -> str -> str
  serviceServiceHandlerName = config: serviceName: config.looniversity.network.services.${serviceName}.handler;

  # serviceServiceHandler :: attrSet -> str -> attrSet
  serviceServiceHandler = config: serviceName: serviceHandler config (serviceServiceHandlerName config serviceName);

  # serviceServiceHandlerHostName :: attrSet -> str -> str
  serviceServiceHandlerHostName = config: serviceName: (serviceServiceHandler config serviceName).host;

  # serviceServiceHandlerHostFQDN :: attrSet -> str -> str
  serviceServiceHandlerHostFQDN = config: serviceName:
    lib.concatStringsSep "."
    [(serviceServiceHandlerHostName config serviceName) (serviceDomainName config serviceName)];
in {
  inherit netdevice lanIpv4;

  inherit serviceHandler;
  inherit serviceHandlerHostName serviceHandlerHostFQDN;
  inherit serviceHandlerNamedPort;

  inherit serviceDomainName;
  inherit serviceServiceHandlerName serviceServiceHandler;
  inherit serviceServiceHandlerHostName serviceServiceHandlerHostFQDN;
}
