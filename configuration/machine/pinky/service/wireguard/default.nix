{
  config,
  lib,
  sops,
  ...
}: let
  wanDev = lib.getNetdevice config "pinky" "wan";
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

        # This allows the wireguard server to route your traffic to the internet and hence be like a VPN
        # For this to work you have to set the dnsserver IP of your router (or dnsserver of choice) in your clients
        postSetup = ''
          ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 10.50.0.0/24 -o ${wanDev} -j MASQUERADE
        '';

        # This undoes the above command
        postShutdown = ''
          ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 10.50.0.0/24 -o ${wanDev} -j MASQUERADE
        '';

        privateKeyFile = sops.secrets."service/wireguard/server/private_key".path;

        peers = [
          {
            publicKey = "{client public key}";
            allowedIPs = ["10.50.0.2/32"];
          }
        ];
      };
    };
  };
}
