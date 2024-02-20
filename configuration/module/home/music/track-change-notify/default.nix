{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.music.notify;
  inherit (lib) mkEnableOption mkIf;

  ffmpeg = "${pkgs.ffmpeg}/bin/ffmpeg";
  mpc = "${pkgs.mpc-cli}/bin/mpc";
  notify_send = "${pkgs.libnotify}/bin/notify-send";
  track-change-notify = pkgs.writeScriptBin "track-change-notify" ''
    #!${pkgs.runtimeShell}
    music_dir="/mnt/music"
    filename="$(${mpc} --format "$music_dir"/%file% current)"

    previewdir="/tmp/ncmpcpp_previews"
    mkdir -p $previewdir
    previewname="$previewdir/$(${mpc} --format %album% current | base64).png"
    [ -e "$previewname" ] || ${ffmpeg} -y -i "$filename" -an -vf scale=256:256 "$previewname" > /dev/null 2>&1

    ${notify_send} -r 27072 "Now Playing" "$(${mpc} --format '%title% by %artist% in %album%' current)" -i "$previewname"  '';
in {
  options.looniversity.music.notify = {
    enable = mkEnableOption "music_notify";
  };

  config = mkIf cfg.enable {
    home.packages = [track-change-notify];

    programs.ncmpcpp.settings.execute_on_song_change = mkIf config.programs.ncmpcpp.enable "${track-change-notify}/bin/track-change-notify &";
  };
}
