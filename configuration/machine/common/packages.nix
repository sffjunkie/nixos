{pkgs, ...}: {
  config = {
    environment.systemPackages = with pkgs; [
      bridge-utils
      dig
      git
      git-lfs
      nano
      nfs-utils
      pciutils
      pipx
      toybox
      unzip
      usbutils
      zip
    ];
  };
}
