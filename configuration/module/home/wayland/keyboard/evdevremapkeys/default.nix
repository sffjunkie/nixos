{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.wayland.keyboard.evdevremapkeys;

  remap-config = ''
    devices:
      - input_name: 'Keychron Keychron K1'
        input_phys: 'usb-0000:0c:00.3-3.3/input1'
        output_name: remap-kbd
        remappings:
          KEY_CAPSLOCK:
          - KEY_ESCAPE
  '';

  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.wayland.keyboard.evdevremapkeys = {
    enable = mkEnableOption "evdevremapkeys";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.evdevremapkeys
    ];

    xdg.configFile."evdevremapkeys/config.yaml".source = remap-config;

    systemd.user.services.evdevremapkeys = {
      Unit = {
        Description = "A daemon to remap key events on linux input devices";
      };
      Install.WantedBy = ["default.target"];
      Service = {
        ExecStart = "${pkgs.evdevremapkeys}/bin/evdevremapkeys";
        PrivateTmp = true;
        NoNewPrivileges = true;
        WorkingDirectory = "/tmp";
      };
    };
  };
}
