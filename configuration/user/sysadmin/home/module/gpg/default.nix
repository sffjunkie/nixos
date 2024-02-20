{
  config,
  pkgs,
  ...
}: {
  programs.gpg = {
    enable = true;
    homedir = "${config.home.homeDirectory}/.local/share/gnupg";
  };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    defaultCacheTtl = 1800;
    pinentryFlavor = "curses";
  };
}
