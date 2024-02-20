{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.qutebrowser;
  inherit (lib) mkDefault mkEnableOption mkIf;
in {
  options.looniversity.qutebrowser = {
    enable = mkEnableOption "qutebrowser";
  };

  config = mkIf cfg.enable {
    programs.qutebrowser = {
      enable = true;

      searchEngines = {
        g = "https://www.google.co.uk/search?hl=en&q={}";
        nw = "https://nixos.wiki/index.php?search={}";
        wp = "https://en.wikipedia.org/wiki/Special:Search?search={}&go=Go&ns0=1";
      };
    };
  };
}
