{
  inputs,
  osConfig,
  pkgs,
  ...
}: {
  imports = [
    inputs.stylix.homeManagerModules.stylix

    ./accounts
    ./settings/qt
    ./settings/qtile
    ./settings/gnome

    ../../common
  ];

  # //config.home-manager.users.sdk.config
  config = {
    programs.home-manager.enable = true;
    home = {
      username = "sdk";
      homeDirectory = "/home/sdk";
      stateVersion = "23.05";
      sessionVariables = {
        MANWIDTH = 100;
        VAULT_ADDR = "http://thebrain.looniversity.net:8200";
        DEVELOPMENT_HOME = "$HOME/development";
      };
    };

    stylix = {
      image = ./settings/desktop/paint_explosion.jpg;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
    };

    xdg.mime.enable = true;

    looniversity = {
      audio.qpwgraph.enable = true;

      role.podcaster.enable = true;

      cava = {
        enable = true;
        settings = {
          input = {
            method = "pipewire";
            source = "auto";
          };
        };
      };
      dunst.enable = true;
      bat.enable = true;
      bottom.enable = true;
      direnv.enable = true;
      dircolors.enable = true;
      exiftool.enable = true;
      feh.enable = true;
      firefox.enable = true;
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
      micro.enable = true;
      neofetch.enable = true;
      neovim.enable = true;
      nushell.enable = true;
      pass.enable = true;
      pulsemixer.enable = true;
      ranger.enable = true;
      ripgrep.enable = true;
      starship.enable = true;
      youtubeDl.enable = true;
      yq.enable = true;
      yubikeyManager.enable = true;
      zellij.enable = true;

      zsh.enable = true;

      alejandra.enable = true;
      gnumake.enable = true;
      preCommit.enable = true;
      shellcheck.enable = true;

      alacritty.enable = true;
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
      kitty.enable = false;
      libreoffice.enable = true;
      mpv.enable = true;
      obsidian.enable = true;
      picard.enable = true;
      qutebrowser.enable = true;
      rofi.enable = true;
      thunderbird.enable = true;
      vscode.enable = true;
      desktop.wallpaper.enable = true;
      wofi.enable = true;
      zathura.enable = true;

      gpg.enable = true;
      imagemagick.enable = true;
      pavucontrol.enable = true;
      pywal.enable = true;
      syncthing.enable = true;
      veracrypt.enable = true;

      music.playback = {
        enable = true;
        uid = osConfig.users.users.sdk.uid;
      };
      music.notify.enable = true;

      scripts.linkhandler.enable = true;
      scripts.paths.enable = true;
      scripts.sysinfo.enable = true;

      settings.gnome.enable = true;
      settings.qt.enable = true;
      settings.qtile.enable = true;

      user-dirs.enable = true;
    };
  };
}
