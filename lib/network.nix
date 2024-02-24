{lib, ...}: rec {
  # netdevice :: attrSet -> str -> str -> str
  # Gets a hosts network device given an alias
  netdevice = config: host: ifname: config.looniversity.network.hosts.${host}.netdevice.${ifname}.device;

  # lanIpv4 :: attrSet -> str -> str
  # Get the ipv4 address of the host's lan network device
  lanIpv4 = config: host: config.looniversity.network.hosts.${host}.netdevice.lan.ipv4;

  # serviceHandlerName -> ...

  # serviceHandler :: attrSet -> str -> attrSet
  # Get the service handler definition for the `serviceHandlerName`
  serviceHandler = config: serviceHandlerName: config.looniversity.network.serviceHandlers.${serviceHandlerName};

  # serviceHandlerMainPort :: attrSet -> str -> str -> int
  # Get a named port number for the `serviceHandlerName`
  serviceHandlerMainPort = config: serviceHandlerName: config.looniversity.network.serviceHandlers.${serviceHandlerName}.port;

  # serviceHandlerNamedPort :: attrSet -> str -> str -> int
  # Get a named port number for the `serviceHandlerName`
  serviceHandlerNamedPort = config: serviceHandlerName: portName: config.looniversity.network.serviceHandlers.${serviceHandlerName}.ports.${portName};

  # serviceHandlerHostName :: attrSet -> str -> str
  # Get the host name for the `serviceName`
  serviceHandlerHostName = config: serviceHandlerName: (serviceHandler config serviceHandlerName).host;

  # serviceHandlerFQDN :: attrSet -> str -> str
  serviceHandlerFQDN = config: serviceHandlerName:
    lib.concatStringsSep "."
    [(serviceHandlerHostName config serviceHandlerName) config.looniversity.network.domainName];

  # serviceName -> ...

  # serviceHostName :: attrSet -> str -> str
  serviceHostName = config: serviceName: config.looniversity.network.services.${serviceName}.hostName;

  # serviceDomainName :: attrSet -> str -> str
  serviceDomainName = config: serviceName: config.looniversity.network.services.${serviceName}.domainName;

  # serviceFQDN :: attrSet -> str -> str
  serviceFQDN = config: serviceName:
    lib.concatStringsSep "."
    [(serviceHostName config serviceName) (serviceDomainName config serviceName)];

  # serviceServiceHandlerName :: attrSet -> str -> str
  serviceServiceHandlerName = config: serviceName: config.looniversity.network.services.${serviceName}.handler;

  # serviceServiceHandler :: attrSet -> str -> attrSet
  serviceServiceHandler = config: serviceName: serviceHandler config (serviceServiceHandlerName config serviceName);
}
