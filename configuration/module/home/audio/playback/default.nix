{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.music.playback;
  inherit (lib) mkEnableOption mkIf;

  mpdListenAddress = "/run/user/1001/mpd.sock";
  mpdFifoAddress = "/run/user/1001/mpd.fifo";
  mpdVisualizerFeedName = "MPD visualizer FIFO";
in {
  options.looniversity.music.playback = {
    enable = mkEnableOption "music_playback";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      mpc-cli
    ];

    services.mpd = {
      enable = true;
      musicDirectory = "/mnt/music";
      network.listenAddress = mpdListenAddress;
      extraConfig = ''
        audio_output {
          type            "pipewire"
          name            "PipeWire Sound Server"
        }

        audio_output {
          type    "fifo"
          name    "${mpdVisualizerFeedName}"
          format  "44100:16:2"
          path    "${mpdFifoAddress}"
        }
      '';
    };

    home.sessionVariables = {
      "MPD_HOST" = mpdListenAddress;
    };

    programs.ncmpcpp = {
      enable = true;
      settings = {
        startup_screen = "playlist";

        message_delay_time = "1";

        song_list_format = "{$4%a - }{%t}|{$8%f$9}$R{$3(%l)$9}";
        song_status_format = "{$8%t} $3by {$4%a{ $2in $7%b $8(Track %N)}}|{$8%f}";
        song_library_format = "{%n - }{%t}|{%f}";
        song_columns_list_format = "(25)[white]{t|f:Title} (37)[green]{a} (37)[cyan]{b} (6f)[white]{NE} (7f)[magenta]{l}";

        alternative_header_first_line_format = "$b$1$aqqu$/a$9 {%t}|{%f} $1$atqq$/a$9$/b";
        alternative_header_second_line_format = "{{$4$b%a$/b$9}{ - $7%b$9}{ ($4%y$9)}}|{%D}";

        current_item_prefix = "$(cyan)$r$b";
        current_item_suffix = "$/r$(end)$/b";
        current_item_inactive_column_prefix = "$(magenta)$r";
        current_item_inactive_column_suffix = "$/r$(end)";

        empty_tag_color = "magenta";
        main_window_color = "white";
        progressbar_color = "black:b";
        progressbar_elapsed_color = "blue:b";
        statusbar_color = "red";
        statusbar_time_color = "cyan:b";
        playlist_display_mode = "columns";
        browser_display_mode = "columns";
        progressbar_look = "->";

        media_library_primary_tag = "album_artist";
        media_library_albums_split_by_date = "no";

        display_volume_level = "no";
        ignore_leading_the = "yes";
        external_editor = "nano";
        use_console_editor = "yes";

        visualizer_data_source = mpdFifoAddress;
        visualizer_output_name = mpdVisualizerFeedName;
        visualizer_in_stereo = "yes";
        visualizer_type = "wave";

        playlist_disable_highlight_delay = 0;
      };
    };
  };
}
