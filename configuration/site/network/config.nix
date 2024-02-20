{config, ...}: {
  config.looniversity.network = {
    network = "10.44.0.0";
    prefixLength = 21;
    domainName = "looniversity.net";
    ldapRoot = "dc=looniversity,dc=net";

    hosts = {
      pinky = {
        description = "Admissions";
        netdevice = {
          wan = {
            device = "enp6s0";
            ipv4method = "pppoe";
          };
          lan = {
            device = "enp5s0";
            ipv4 = "10.44.0.1";
            ipv4method = "static";
          };
        };
      };
      thebrain = {
        description = "Service Centre";
        netdevice = {
          lan = {
            device = "eno1";
            mac = "14:DD:A9:C9:90:68";
            ipv4 = "10.44.0.2";
            ipv4method = "dhcpstatic";
          };
        };
      };
      babs = {
        description = "Storage Server";
        netdevice = {
          lan = {
            device = "eno1";
            mac = "18:c0:4d:04:92:ee";
            ipv4 = "10.44.0.3";
            ipv4method = "dhcpstatic";
          };
        };
      };
      mary = {
        description = "Music Server";
        netdevice = {
          lan = {
            device = "enp5s0";
            mac = "TBC";
            ipv4 = "10.44.0.4";
            ipv4method = "dhcpstatic";
          };
        };
      };
      calamity = {
        description = "Backup Server";
        netdevice = {
          lan = {
            device = "enp5s0";
            mac = "TBC";
            ipv4 = "10.44.0.5";
            ipv4method = "dhcpstatic";
          };
        };
      };
      furrball = {
        description = "Workstation";
        netdevice = {
          wifi = {
            device = "wlp3s0";
            mac = "44:AF:28:15:B3:B9";
            ipv4method = "dhcp";
          };
        };
      };
      buster = {
        description = "Laptop";
        netdevice = {
          wifi = {
            device = "TBC";
            ipv4method = "dhcp";
            mac = "TBC";
          };
        };
      };
      sw1 = {
        description = "Node0 Switch";
        netdevice = {
          lan = {
            ipv4 = "10.44.0.10";
            ipv4method = "dhcpstatic";
            mac = "10:DA:43:D9:D9:D1";
          };
        };
      };
      wa1 = {
        description = "Downstairs WAP";
        netdevice = {
          lan = {
            ipv4 = "10.44.0.11";
            ipv4method = "dhcpstatic";
            mac = "FC:EC:DA:3D:47:87";
          };
        };
      };
      wa2 = {
        description = "Upstairs WAP";
        netdevice = {
          lan = {
            ipv4 = "10.44.0.12";
            ipv4method = "dhcpstatic";
            mac = "FC:EC:DA:3D:85:4E";
          };
        };
      };
      wr1 = {
        description = "HiFi Repeater";
        netdevice = {
          lan = {
            ipv4 = "10.44.0.6";
            ipv4method = "dhcpstatic";
            mac = "74:DA:88:5D:37:00";
          };
        };
      };
    };

    vlans = {
      guest = {
        id = 10;
        network = "10.44.10.0";
        prefixLength = 24;
      };
      iot = {
        id = 20;
        network = "10.44.20.0";
        prefixLength = 24;
      };
      not = {
        id = 30;
        network = "10.44.30.0";
        prefixLength = 24;
      };
    };

    services = {
      defaults = {
        domainName = "service.${config.looniversity.network.domainName}";
      };

      ca.handler = "step-ca";
      cloud.handler = "nextcloud";
      dhcp4.handler = "kea";
      dns.handler = "coredns";
      home-automation.handler = "home-assistant";
      log.handler = "graylog";
      metrics.handler = "prometheus";
      music.handler = "jellyfin";
      proxy.handler = "traefik";
      s3.handler = "minio";
      sync.handler = "syncthing";
    };

    serviceHandlers = {
      coredns = {
        host = "pinky";
        port = 53;
        config = {
          dynamicZoneDataDir = "/var/lib/coredns/dynamic";
        };
      };

      elasticsearch = {
        host = "thebrain";
      };

      graylog = {
        host = "thebrain";
        port = 9013;
      };

      home-assistant = {
        host = "thebrain";
        port = 8123;
      };

      jellyfin = {
        host = "mary";
        ports = {
          ui = 8096;
          ui_https = 8920;
        };
      };

      kea = {
        host = "pinky";
        port = 67;
      };

      minio = {
        host = "babs";
        ports = {
          listen = 9011;
          console = 9012;
        };
      };

      mongodb = {
        host = "thebrain";
      };

      nextcloud = {
        host = "thebrain";
      };

      portainer = {
        host = "thebrain";
        port = 9000;
      };

      prometheus = {
        host = "thebrain";
        port = 9153;
      };

      step-ca = {
        host = "pinky";
      };

      syncthing.host = "babs";

      traefik = {
        host = "pinky";
        ports = {
          dashboard = "8080";
        };
      };
    };
  };
}
