{pkgs, ...}: {
  config = {
    environment.systemPackages = with pkgs; [
      git
      git-lfs
      nano
      pciutils
      # pipx # BUG: Failing tests
      psmisc
      unzip
      usbutils
      zip
    ];
  };
}
