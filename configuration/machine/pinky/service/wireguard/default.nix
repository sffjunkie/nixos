{
  config,
  lib,
  sops,
  ...
}: let
  wanDev = lib.network.getNetdevice config "pinky" "wan";
in {
  config = {
    sops.secrets."service/wireguard/server/private_key" = {};

    environment.systemPackages = [
      pkgs.wireguard-tools
    ];

    networking.firewall.interfaces.allowedUDPPorts = [51820];

    networking.wireguard.interfaces = {
      wg0 = {
        ips = ["10.50.0.1/24"];

        listenPort = 51820;

        postSetup = ''
          ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 10.50.0.0/24 -o ${wanDev} -j MASQUERADE
        '';

        postShutdown = ''
          ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 10.50.0.0/24 -o ${wanDev} -j MASQUERADE
        '';

        privateKeyFile = sops.secrets."service/wireguard/server/private_key".path;

        peers = [
          {
            publicKey = "KiKUDMFNPA5wFSQ79FFoVnFiiBN1PYq6K1OCO6zSEjY=";
            allowedIPs = ["10.50.0.2/32"];
          }
        ];
      };
    };
  };
}
