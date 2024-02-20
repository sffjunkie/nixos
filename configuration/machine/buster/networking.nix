{lib, ...}: {
  config = {
    networking = {
      hostId = "e9313abd";
      hostName = "buster";
      domain = "looniversity.net";

      useDHCP = lib.mkDefault true;
      # interfaces.enp0s20f0u1u2.useDHCP = lib.mkDefault true;
      # interfaces.wlp0s20f3.useDHCP = lib.mkDefault true;
    };
  };
}
