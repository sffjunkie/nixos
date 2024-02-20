{lib, ...}: {
  config = {
    networking = {
      hostId = "fafececd";
      hostName = "babs";
      domain = "looniversity.net";

      useDHCP = lib.mkDefault true;
      # interfaces.enp4s0.useDHCP = lib.mkDefault true;
      # interfaces.wlp3s0.useDHCP = lib.mkDefault true;
    };
  };
}
