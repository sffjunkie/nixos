{pkgs, ...}: {
  config = {
    environment.systemPackages = with pkgs; [
      git
      git-lfs
      nano
      pciutils
      pipx
      # toybox
      unzip
      usbutils
      zip
    ];
  };
}
