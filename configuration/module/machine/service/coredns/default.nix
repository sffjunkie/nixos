{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.service.coredns;
  lanDev = lib.traceVal lib.getNetdevice config "pinky" "lan";
  lanIpv4 = lib.getLanIpv4 config "pinky";
  dynamicZoneDataDir = "/var/lib/coredns/dynamic";

  dnsPort = 1053;

  ttl = 180;

  # TODO: version number needs to change before auto will load new zone files
  staticZoneDataFile = pkgs.writeText "looniversity.zone" ''
    $ORIGIN ${config.looniversity.network.domainName}.
    @       IN SOA ns nomail (
            2024021401  ; Version number
            60          ; Zone refresh interval
            30          ; Zone update retry timeout
            ${toString ttl}         ; Zone TTL
            3600)       ; Negative response TTL

    looniversity. IN NS ns.${config.looniversity.network.domainName}.

    ; Static IPs
    ns            ${toString ttl} IN   A     ${lanIpv4}
  '';

  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.service.coredns = {
    enable = mkEnableOption "coredns";
  };

  config = mkIf cfg.enable {
    services.coredns = {
      enable = true;

      config = ''
        .:${toString dnsPort} {
          forward . 1.1.1.1 8.8.8.8
          cache
          log
        }

        ${config.looniversity.network.domainName}:${toString dnsPort} {
          cache
          file ${staticZoneDataFile}
          auto {
            directory ${config.looniversity.network.serviceHandlers.coredns.config.dynamicZoneDataDir}
          }
          log
        }
      '';
    };

    systemd.services.coredns.serviceConfig = {
      StateDirectory = "coredns";
    };

    system.activationScripts.makeDNSDynamicZoneDataDir = ''
      mkdir -p ${dynamicZoneDataDir}
    '';

    networking.firewall.interfaces.${lanDev} = {
      allowedTCPPorts = [dnsPort];
      allowedUDPPorts = [dnsPort];
    };
  };
}
