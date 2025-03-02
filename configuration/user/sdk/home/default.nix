{
  config,
  inputs,
  lib,
  osConfig,
  pkgs,
  ...
}:
let
  inherit (lib) disabled enabled;
in
{
  imports = [
    ./accounts
    ./settings

    ../../common
  ];

  # config = osConfig.home-manager.users.sdk.config
  config = {
    programs.home-manager = enabled;
    home = {
      username = "sdk";
      homeDirectory = "/home/sdk";
      stateVersion = "23.05";
      sessionVariables = {
        BROWSER = "brave";
        EDITOR = "micro";
        TERMINAL = "alacritty";

        MANWIDTH = 100;
        VAULT_ADDR = "http://thebrain.looniversity.net:8200";
        DEVELOPMENT_HOME = "$HOME/development";

        SOPS_AGE_KEY_FILE = "$HOME/secrets/sops/age/keys.txt";
      };
    };

    stylix = {
      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";
      targets.vscode.enable = false;
    };

    xdg.mime = enabled;

    looniversity = {
      audio = {
        easyeffects = enabled;
        qpwgraph = enabled;
      };

      role = {
        podcaster = enabled;
      };

      cli = {
        atuin = disabled;
        bat = enabled;
        beancount = enabled;
        bottom = enabled;
        cava = enabled // {
          settings = {
            input = {
              method = "pipewire";
              source = "auto";
            };
          };
        };
        dircolors = enabled;
        exiftool = enabled;
        fd = enabled;
        feh = enabled;
        fzf = enabled;
        gh = enabled;
        git = enabled;
        htop = enabled;
        jc = enabled;
        jq = enabled;
        just = enabled;
        khal = enabled;
        lazydocker = enabled;
        lazygit = enabled;
        lsd = enabled;
        neofetch = enabled;
        pass = enabled;
        pulsemixer = enabled;
        ranger = enabled;
        ripgrep = enabled;
        slurm = enabled;
        starship = enabled;
        youtubeDl = enabled;
        yq = enabled;
        yubikeyManager = enabled;
        zellij = enabled;
      };

      desktop = {
        dunst = disabled;
        mako = enabled;
        wallpaper = enabled;
      };

      development = {
        alejandra = enabled;
        devenv = enabled;
        direnv = enabled;
        gnumake = enabled;
        nixfmt = enabled;
        pre-commit = enabled;
        shellcheck = enabled;
        treefmt = enabled;
      };

      game = {
        openmw = enabled;
      };

      gui = {
        fava = enabled;
        firefox = enabled;
        brave = enabled;
        darktable = enabled;
        discord = enabled;
        gimp = enabled;
        gittyup = enabled;
        gnomeApps = enabled;
        gns3 = enabled;
        gramps = enabled;
        inkscape = enabled;
        keepassxc = enabled;
        libreoffice = enabled;
        mpv = enabled;
        obsidian = enabled;
        picard = enabled;
        qutebrowser = enabled;
        rofi = enabled;
        seahorse = enabled;
        streamdeck = enabled;
        thunderbird = enabled;
        wofi = enabled;
        zathura = enabled;
      };

      editor = {
        micro = enabled;
        nixvim = enabled;
        vscode = enabled;
      };

      terminal = {
        alacritty = enabled;
        kitty = disabled;
      };

      media = {
        playerctl = enabled;
      };

      music = {
        mpd = enabled // {
          uid = osConfig.users.users.sdk.uid;
        };
        musicctl = enabled;
        ncmpcpp = enabled;
        notify = enabled;
      };

      script = {
        linkhandler = enabled;
        paths = enabled;
        sysinfo = enabled;
      };

      settings = {
        gnome = enabled;
      };

      service = {
        syncthing = enabled;
      };

      shell = {
        nushell = enabled;
        zsh = enabled // {
          initExtra = ''
            bindkey ^f autosuggest-accept
            function browser() { command "''${BROWSER:-${config.home.sessionVariables.BROWSER}}" "$@"; }
            function edit() { command "''${EDITOR:-${config.home.sessionVariables.EDITOR}}" "$@"; }
            function terminal() { command "''${TERMINAL:-${config.home.sessionVariables.TERMINAL}}" "$@"; }
          '';
        };
      };

      storage = {
        udiskie = enabled;
        veracrypt = enabled;
      };

      system = {
        gpg = enabled;
        imagemagick = enabled;
        polkit-agent = enabled;
        pywal = enabled;
        user-dirs = enabled;
      };

      wayland = {
        clipboard.cliphist = enabled;
        display = {
          kanshi = enabled;
          wdisplays = enabled;
        };
        screenshot.sshot = enabled;
        keyboard.hyper_super = enabled;
        lockscreen.swaylock = enabled;
      };
    };
  };
}
