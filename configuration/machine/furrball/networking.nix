{lib, ...}: {
  config = {
    networking = {
      hostId = "8ddbb68e";
      hostName = "furrball";
      domain = "looniversity.net";
      networkmanager.enable = true;

      useDHCP = lib.mkDefault true;
      # interfaces.enp4s0.useDHCP = lib.mkDefault true;
      # interfaces.wlp3s0.useDHCP = lib.mkDefault true;
    };
  };
}
