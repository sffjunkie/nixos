{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.music.mpd;
  inherit (lib) mkEnableOption mkIf mkOption types;

  mpdFifoAddress = "/run/user/${toString cfg.uid}/mpd.fifo";
in {
  options.looniversity.music.mpd = {
    enable = mkEnableOption "music mpd";

    uid = mkOption {
      type = types.int;
      default = 1000;
    };

    mpdHost = mkOption {
      type = types.str;
      default = "localhost";
    };

    mpdPort = mkOption {
      type = types.port;
      default = 6600;
    };

    mpdFifoAddress = mkOption {
      type = types.str;
      default = mpdFifoAddress;
    };

    mpdVisualizerFeedName = mkOption {
      type = types.str;
      default = "MPD visualizer FIFO";
    };
  };

  config = mkIf cfg.enable {
    services.mpdris2 = {
      enable = true;
    };

    services.mpd = {
      enable = true;
      musicDirectory = "/mnt/music";
      network = {
        listenAddress = config.looniversity.music.mpd.mpdHost;
        port = config.looniversity.music.mpd.mpdPort;
      };
      extraConfig = ''
        audio_output {
          type            "pipewire"
          name            "PipeWire Sound Server"
        }

        audio_output {
          type    "fifo"
          name    "${config.looniversity.music.mpd.mpdVisualizerFeedName}"
          format  "44100:16:2"
          path    "${config.looniversity.music.mpd.mpdFifoAddress}"
        }
      '';
    };
  };
}
