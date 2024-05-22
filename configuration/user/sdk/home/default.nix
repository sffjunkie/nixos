{
  config,
  inputs,
  osConfig,
  pkgs,
  ...
}: {
  imports = [
    ./accounts
    ./settings

    ../../common
  ];

  # config = osConfig.home-manager.users.sdk.config
  config = {
    programs.home-manager.enable = true;
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
      };
    };

    stylix = {
      image = ./desktop/paint_explosion.jpg;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-frappe.yaml";
      targets.vscode.enable = false;
    };

    xdg.mime.enable = true;

    looniversity = {
      audio = {
        easyeffects.enable = true;
        qpwgraph.enable = true;
      };

      role = {
        podcaster.enable = true;
      };

      cli = {
        atuin.enable = false;
        bat.enable = true;
        bottom.enable = true;
        cava = {
          enable = true;
          settings = {
            input = {
              method = "pipewire";
              source = "auto";
            };
          };
        };
        dircolors.enable = true;
        exiftool.enable = true;
        fd.enable = true;
        feh.enable = true;
        fzf.enable = true;
        gh.enable = true;
        git.enable = true;
        htop.enable = true;
        jc.enable = true;
        jq.enable = true;
        just.enable = true;
        khal.enable = true;
        lazydocker.enable = true;
        lazygit.enable = true;
        lsd.enable = true;
        neofetch.enable = true;
        pass.enable = true;
        pulsemixer.enable = true;
        ranger.enable = true;
        ripgrep.enable = true;
        starship.enable = true;
        youtubeDl.enable = true;
        yq.enable = true;
        yubikeyManager.enable = true;
        zellij.enable = true;
      };

      desktop = {
        dunst.enable = true;
        wallpaper.enable = true;
      };

      development = {
        direnv.enable = true;
        alejandra.enable = true;
        gnumake.enable = true;
        pre-commit.enable = true;
        shellcheck.enable = true;
      };

      gui = {
        firefox.enable = true;
        brave.enable = true;
        darktable.enable = true;
        discord.enable = true;
        gimp.enable = true;
        gittyup.enable = true;
        gnomeApps.enable = true;
        # gns3.enable = true; # BUG: Failing tests
        gramps.enable = true;
        inkscape.enable = true;
        keepassxc.enable = true;
        libreoffice.enable = true;
        mpv.enable = true;
        obsidian.enable = true;
        picard.enable = true;
        qutebrowser.enable = true;
        rofi.enable = true;
        thunderbird.enable = true;
        wofi.enable = true;
        zathura.enable = true;
      };

      editor = {
        micro.enable = true;
        neovim.enable = false;
        nixvim.enable = true;
        vscode.enable = true;
      };

      terminal = {
        alacritty.enable = true;
        kitty.enable = false;
      };

      media = {
        playerctl.enable = true;
      };

      music = {
        mpd = {
          enable = true;
          uid = osConfig.users.users.sdk.uid;
        };
        musicctl.enable = true;
        ncmpcpp.enable = true;
        notify.enable = true;
      };

      script = {
        linkhandler.enable = true;
        paths.enable = true;
        sysinfo.enable = true;
      };

      settings = {
        gnome.enable = true;
        qt.enable = true;
        qtile.enable = true;
      };

      service = {
        syncthing.enable = true;
      };

      shell = {
        nushell.enable = true;
        zsh = {
          enable = true;

          initExtra = ''
            bindkey ^f autosuggest-accept
            function browser() { command "''${BROWSER:-${config.home.sessionVariables.BROWSER}}" "$@"; }
            function edit() { command "''${EDITOR:-${config.home.sessionVariables.EDITOR}}" "$@"; }
            function terminal() { command "''${TERMINAL:-${config.home.sessionVariables.TERMINAL}}" "$@"; }
          '';
        };
      };

      storage = {
        udiskie.enable = true;
        veracrypt.enable = true;
      };

      system = {
        gpg.enable = true;
        imagemagick.enable = true;
        polkit-agent.enable = true;
        pywal.enable = true;
        user-dirs.enable = true;
      };

      wayland = {
        clipboard.cliphist.enable = true;
        display = {
          kanshi.enable = true;
          wdisplays.enable = true;
        };
        screenshot.sshot.enable = true;
        keyboard.hyper_super.enable = true;
        lockscreen.swaylock.enable = true;
      };
    };
  };
}
