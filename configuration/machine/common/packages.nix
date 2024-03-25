{pkgs, ...}: {
  config = {
    environment.systemPackages = with pkgs; [
      git
      git-lfs
      nano
      pciutils
      psmisc
      unzip
      usbutils
      zip
    ];
  };
}
