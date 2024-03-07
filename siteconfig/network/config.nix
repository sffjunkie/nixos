{config, ...}: {
  config.looniversity.network = {
    network = "10.44.0.0";
    prefixLength = 21;
    domainName = "looniversity.net";
    ldapRoot = "dc=looniversity,dc=net";
    nameServer = "10.44.0.1";
    extraNameServers = [
      "8.8.8.8"
      "1.1.1.1"
    ];

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
            mac = "TBC"; # TODO: Add correct MAC
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
            device = "TBC"; # TODO: Add correct wifi device
            ipv4method = "dhcp";
            mac = "TBC"; # TODO: Add correct MAC
          };
        };
      };
      # mary = {
      #   description = "Music Server";
      #   netdevice = {
      #     lan = {
      #       device = "enp5s0";
      #       mac = "TBC";
      #       ipv4 = "10.44.0.4";
      #       ipv4method = "dhcpstatic";
      #     };
      #   };
      # };
      # calamity = {
      #   description = "Backup Server";
      #   netdevice = {
      #     lan = {
      #       device = "enp5s0";
      #       mac = "TBC";
      #       ipv4 = "10.44.0.5";
      #       ipv4method = "dhcpstatic";
      #     };
      #   };
      # };

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

      # Wifi access points
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
            ipv4 = "10.44.0.13";
            ipv4method = "dhcpstatic";
            mac = "74:DA:88:5D:37:00";
          };
        };
      };

      # IoT
      philips-hue = {
        description = "Philips Hue";
        netdevice = {
          lan = {
            ipv4 = "10.44.0.21";
            ipv4method = "dhcpstatic";
            mac = "00:17:88:24:a4:6d";
          };
        };
      };

      # Media devices
      gh-bedroom = {
        netdevice = {
          lan = {
            ipv4 = "10.44.0.50";
            ipv4method = "dhcpstatic";
            mac = "a4:77:33:2f:59:aa";
          };
        };
      };
      gh-mediaroom = {
        netdevice = {
          lan = {
            ipv4 = "10.44.0.51";
            ipv4method = "dhcpstatic";
            mac = "d8:6c:63:4b:d4:5e";
          };
        };
      };
      gh-dressingroom = {
        netdevice = {
          lan = {
            ipv4 = "10.44.0.52";
            ipv4method = "dhcpstatic";
            mac = "20:df:b9:2d:f2:92";
          };
        };
      };
      gh-kitchen = {
        netdevice = {
          lan = {
            ipv4 = "10.44.0.53";
            ipv4method = "dhcpstatic";
            mac = "48:d6:d5:f4:1b:bd";
          };
        };
      };
      gh-lounge = {
        netdevice = {
          lan = {
            ipv4 = "10.44.0.54";
            ipv4method = "dhcpstatic";
            mac = "d4:f5:47:bd:39:6d";
          };
        };
      };
      gh-garage = {
        netdevice = {
          lan = {
            ipv4 = "10.44.0.55";
            ipv4method = "dhcpstatic";
            mac = "48:d6:d5:db:83:2d";
          };
        };
      };
      ca-kitchen = {
        netdevice = {
          lan = {
            ipv4 = "10.44.0.60";
            ipv4method = "dhcpstatic";
            mac = "54:60:09:f9:ef:da";
          };
        };
      };
      ca-garage = {
        netdevice = {
          lan = {
            ipv4 = "10.44.0.61";
            ipv4method = "dhcpstatic";
            mac = "54:60:09:f9:f0:ae";
          };
        };
      };
      cxn-lounge = {
        description = "CXNv2";
        netdevice = {
          lan = {
            ipv4 = "10.44.0.62";
            ipv4method = "dhcpstatic";
            mac = "b4:bc:7c:bf:01:ca";
          };
        };
      };
      gtv-bedroom = {
        description = "Google TV";
        netdevice = {
          lan = {
            ipv4 = "10.44.0.63";
            ipv4method = "dhcpstatic";
            mac = "e2:3e:79:61:b6:bd";
          };
        };
      };
      sb-mediaroom = {
        description = "Sonos Beam";
        netdevice = {
          lan = {
            ipv4 = "10.44.0.64";
            ipv4method = "dhcpstatic";
            mac = "94:9f:3e:c5:56:fe";
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
      ca = {
        handlerName = "step-ca";
        addToDns = true;
      };
      cloud.handlerName = "nextcloud";
      dhcp4.handlerName = "kea";
      dns.handlerName = "coredns";
      git.handlerName = "gitea";
      home-automation.handlerName = "home-assistant";
      log.handlerName = "graylog";
      metrics.handlerName = "prometheus";
      music.handlerName = "jellyfin";
      proxy.handlerName = "traefik";
      s3.handlerName = "minio";
      sync.handlerName = "syncthing";
      zigbee.handlerName = "zigbee2mqtt";
    };

    serviceHandlers = {
      camo = {
        # host = "thebrain";
        host = "127.0.0.1";
        port = "8081";
      };

      coredns = {
        host = "pinky";
        port = 53;
        config = {
          dynamicZoneDataDir = "/var/lib/coredns/dynamic";
        };
      };

      elasticsearch = {
        # host = "thebrain";
        host = "127.0.0.1";
      };

      gitea = {
        # host = "thebrain";
        host = "127.0.0.1";
        port = 3000;
      };

      graylog = {
        # host = "thebrain";
        host = "127.0.0.1";
        port = 9011;
      };

      home-assistant = {
        # host = "thebrain";
        host = "127.0.0.1";
        port = 8123;
      };

      homepage-dashboard = {
        port = 9014;
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
        # host = "thebrain";
        host = "127.0.0.1";
      };

      mosquitto = {
        host = "10.44.1.1";
      };

      nextcloud = {
        # host = "thebrain";
        host = "127.0.0.1";
      };

      portainer = {
        # host = "thebrain";
        host = "127.0.0.1";
        port = 9000;
      };

      prometheus = {
        # host = "thebrain";
        host = "127.0.0.1";
        port = 9153;
      };

      step-ca = {
        host = "pinky";
      };

      syncthing.host = "babs";

      traefik = {
        host = "pinky";
        ports = {
          dashboard = 8080;
        };
      };

      zigbee2mqtt = {
        # host = "thebrain";
        host = "127.0.0.1";
        port = 8080;
      };
    };
  };
}
