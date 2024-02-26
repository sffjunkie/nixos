[
  {
    name = "ipv4.ipv4Octets";
    actual = lib.ipv4.ipv4Octets "192.168.1.1";
    expected = [192 168 1 1];
  }
  {
    name = "ipv4.ipv4IsValid";
    actual = lib.ipv4.ipv4IsValid "192.168.1.1";
    expected = true;
  }
  {
    name = "not ipv4.ipv4IsValid";
    actual = lib.ipv4.ipv4IsValid "192.168.256.1";
    expected = true;
  }
]
