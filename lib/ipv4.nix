{lib, ...}: rec {
  ipv4Octets = ipv4: map (item: lib.toInt item) (lib.splitString "." ipv4);

  # ipv4IsValid = str -> bool
  ipv4IsValid = ipv4: let
    octets = map (item: lib.toInt item) (lib.splitString "." ipv4);
  in
    all (item: item < 256) octets;

  # ipv4Is24BitBlock = str -> bool
  ipv4Is24BitBlock = ipv4: (lib.elemAt 0 (lib.splitString "." ipv4)) == "10";

  # ipv4Is20BitBlock = str -> bool
  ipv4Is20BitBlock = ipv4: let
    octets = map (item: lib.toInt item) (lib.splitString "." ipv4);
    part1 = lib.elemAt 1 octets;
  in
    (lib.elemAt 0 octets) == 172 && (part1 >= 16 && part1 <= 31);

  # ipv4Is16BitBlock = str -> bool
  ipv4Is16BitBlock = ipv4: let
    octets = map (item: lib.toInt item) (lib.splitString "." ipv4);
  in
    (lib.elemAt 0 octets) == 192 && (lib.elemAt 1 octets) == 168;

  # constructIpv4Address = str -> str -> str
  constructIpv4Address = networkPart: hostPart: let
    networkOctets = ipv4Octets networkPart;
    hostOctets = ipv4Octets hostPart;

    addr = lib.concatStringsSep "." [(lib.init networkOctets) hostPart];
  in
    addr;
}
# 172.16.x.x -> 172.31.x.255
# 192.168.x.x -> 192.168.255.255
# 10.x.x.x

