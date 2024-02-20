{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.sxhkd;
  inherit (lib) mkIf;
in {
  config = mkIf cfg.enable {
    services.sxhkd = {
      enable = true;
      keybindings = {
        "super + alt + Escape" = "pkill -USR1 -x sxhkd; notify-send 'sxhkd' 'Reloaded sxhkd config'";
        "super + {Return,t}" = "$TERMINAL";
        "super + alt + @space" = "rofi -modi drun -show drun";
        "super + alt + Delete" = "arandr";
        "super + alt + g" = "ranger";
        "super + alt + m" = "$HOME/.local/bin/musicplayer";
        "super + alt + v" = "$TERMINAL --class='visualizer' -e $HOME/.local/bin/visualizer";
        "super + alt + b" = "$HOME/.local/bin/browser";
        "super + alt + c" = "code";
        "super + alt + h" = "htop";
        "XF86AudioPause" = "mpc toggle";
        "super + alt + Pause" = "mpc toggle";
        "super + alt + Prior" = "mpc prev";
        "XF86AudioPrev" = "mpc prev";
        "super + alt + Next" = "mpc next";
        "super + alt + Scroll_Lock" = "$HOME/.local/bin/vol toggle";
        "XF86AudioMute" = "$HOME/.local/bin/vol toggle";
        "super + alt + Home" = "$HOME/.local/bin/vol up";
        "XF86AudioRaiseVolume" = "$HOME/.local/bin/vol up";
        "super + alt + End" = "$HOME/.local/bin/vol down";
        "XF86AudioLowerVolume" = "$HOME/.local/bin/vol down";
        "XF86AudioPlay" = "mpc play";
        "XF86AudioStop" = "mpc stop";
        "super + alt + Insert" = "pavucontrol";
      };
    };
  };
}
