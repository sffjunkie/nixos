let
  Alt = "mod1";
  Super = "mod4";
in {
  config = {
    qtile.wm.keys = [
      {
        modifiers = [Super Alt];
        key = "b";
        cmd = ''spawn(environ.get("BROWSER", "brave"))'';
      }
      {
        modifiers = [Super Alt];
        key = "c";
        cmd = ''spawn("code")'';
      }
      {
        modifiers = [Super Alt];
        key = "t";
        cmd = ''spawn("alacritty")'';
      }
    ];
  };
}
