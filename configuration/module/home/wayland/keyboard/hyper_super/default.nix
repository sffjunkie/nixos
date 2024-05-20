# https://www.reddit.com/r/swaywm/comments/1b8hw3u/comment/ktqd5a3/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.wayland.keyboard.hyper_super;
  inherit (lib) mkEnableOption mkIf mkOption types;
in {
  options.looniversity.wayland.keyboard.hyper_super = {
    enable = mkEnableOption "separate hyper and super keys";

    name = mkOption {
      type = types.str;
      default = "hyper_super";
    };
  };

  config = mkIf cfg.enable {
    home.file.".xkb/symbols/${config.looniversity.wayland.keyboard.hyper_super.name}".text = ''
      default partial modifier_keys

      xkb_symbols "basic" {
        include "us(basic)"
        name[Group1] = "US Keyboard, Separate HYPER_L and SUPER_L";
        modifier_map Mod3 { Hyper_L };
        modifier_map Mod4 { Super_L };
      };
    '';
  };
}
