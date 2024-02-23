{
  imports = [
    ./l10n.nix
    ./modules.nix
    ./nix.nix
    ./packages.nix
    ./workaround.nix
    ../../site
  ];

  config = {
    environment.shellAliases = {
      df = "df -h";
      dfs = "df -ha | (read -r; printf \"%s\\n\" \"\$REPLY\"; sort)";
      dmesg = "dmesg -T";
      free = "free -h";
      nano = "nano -l --guidestripe=72";
      hgrep = "history | grep";
    };

    environment.interactiveShellInit = ''
      ff() { loc=$1; shift; find $loc -type f "$@"; }
      fft() { loc=$1; shift; find $loc -type f -printf "%CY-%Cm-%Cd %CH:%CM %p\n" "$@"; }
      ffts() { loc=$1; shift; find $loc -type f -printf "%CY-%Cm-%Cd %CH:%CM %p\n" "$@" | sort; }
      fd() { loc=$1; shift; find $loc -type d "$@"; }
      fdt() { loc=$1; shift; find $loc -type d -printf "%CY-%Cm-%Cd %CH:%CM %p\n" "$@"; }
      fdts() { loc=$1; shift; find $loc -type d -printf "%CY-%Cm-%Cd %CH:%CM %p\n" "$@" | sort; }

      cdl() { cd $1; ls -l; }
    '';
  };
}
