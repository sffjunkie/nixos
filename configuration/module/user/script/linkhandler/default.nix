{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.looniversity.script.linkhandler;

  linkhandler = pkgs.writeScriptBin "linkhandler" ''
    #!${pkgs.runtimeShell}

    # Feed script a url or file location.
    # If an image, it will view in feh,
    # if a video or gif, it will view in mpv
    # if a music file or pdf, it will download,
    # otherwise it opens link in browser.

    if [ -z "$1" ]; then
      url="$(xclip -o)"
    else
      url="$1"
    fi

    case "$url" in
      *mkv|*webm|*mp4|*youtube.com/watch*|*youtube.com/playlist*|*youtu.be*|*hooktube.com*|*bitchute.com*|*videos.lukesmith.xyz*|*odysee.com*)
        setsid -f ${pkgs.mpv}/bin/mpv -quiet "$url" >/dev/null 2>&1
        ;;

      *png|*jpg|*jpe|*jpeg|*gif|*bmp)
        tmpfile="/tmp/$(echo "$url" | sed "s/.*\///;s/%20/ /g")"
        curl -sL "$url" > "$tmpfile" && ${pkgs.feh}/bin/feh "$tmpfile"
        ;;

      *pdf|*cbz|*cbr)
        curl -sL "$url" > "/tmp/$(echo "$url" | sed "s/.*\///;s/%20/ /g")" && ${pkgs.zathura}/bin/zathura "/tmp/$(echo "$url" | sed "s/.*\///;s/%20/ /g")"  >/dev/null 2>&1 &
        ;;

      *mp3|*flac|*opus|*mp3?source*)
        qndl "$url" 'curl -LO'  >/dev/null 2>&1
        ;;

      *)
        [ -f "$url" ] && setsid -f "$TERMINAL" -e "$EDITOR" "$url" >/dev/null 2>&1 || setsid -f "$BROWSER" "$url" >/dev/null 2>&1
    esac
  '';

  inherit (lib) mkDefault mkEnableOption mkIf;
in
{
  options.looniversity.script.linkhandler = {
    enable = mkEnableOption "linkhandler";
  };

  config = mkIf cfg.enable {
    home.packages = [ linkhandler ];
  };
}
