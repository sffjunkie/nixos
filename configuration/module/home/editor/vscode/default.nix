{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.editor.vscode;
  inherit (lib) mkDefault mkEnableOption mkIf;

  vscodeExtensions = with pkgs.vscode-extensions; [
    arcticicestudio.nord-visual-studio-code
    bbenoist.nix
    bierner.markdown-mermaid
    davidanson.vscode-markdownlint
    editorconfig.editorconfig
    donjayamanne.githistory
    dotjoshjohnson.xml
    github.vscode-github-actions
    golang.go
    gruntfuggly.todo-tree
    humao.rest-client
    kamadorueda.alejandra
    ms-python.python
    ms-python.vscode-pylance
    ms-vscode.makefile-tools
    ms-vscode-remote.remote-containers
    oderwat.indent-rainbow
    pkief.material-icon-theme
    serayuzgur.crates
    shd101wyy.markdown-preview-enhanced
    stkb.rewrap
    tamasfe.even-better-toml
    timonwong.shellcheck
    twxs.cmake
    yzhang.markdown-all-in-one
    zxh404.vscode-proto3
  ];

  marketplaceExtensionsList = with inputs.nix-vscode-extensions.extensions.${pkgs.system}.vscode-marketplace; [
    catppuccin.catppuccin-vsc
    charliermarsh.ruff
    dlasagno.rasi
    executablebookproject.myst-highlight
    github.remotehub
    ms-vscode.cpptools-extension-pack
    ramyaraoa.show-offset
    rust-lang.rust-analyzer
    shipitsmarter.sops-edit
    skellock.just
    techer.open-in-browser
    tomphilbin.gruvbox-themes
  ];
in {
  options.looniversity.editor.vscode = {
    enable = mkEnableOption "vscode";
  };

  config = mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      package = pkgs.vscode.fhs;

      mutableExtensionsDir = true;
      extensions = vscodeExtensions ++ marketplaceExtensionsList;

      userSettings = {
        "cSpell.enabled" = false;

        "diffEditor.ignoreTrimWhitespace" = false;

        "editor.fontFamily" = "'Hack Nerd Font', 'DejaVu Sans Mono', monospace";
        "editor.fontSize" = 12;
        "editor.tokenColorCustomizations" = {
          "[Nord]" = {
            "comments" = "#94b9a6";
          };
        };
        "editor.formatOnSave" = true;
        "editor.lineNumbers" = "relative";
        "editor.parameterHints.enabled" = false;

        "editor.rulers" = [
          80
          100
        ];

        "explorer.confirmDragAndDrop" = false;
        "explorer.compactFolders" = false;

        "files.associations" = {
          "*.just" = "just";
        };
        "files.insertFinalNewline" = true;
        "files.exclude" = {
          "**/.tox" = true;
          ".direnv" = true;
        };

        "git.confirmSync" = false;
        "git.openRepositoryInParentFolders" = "never";

        "markdown.preview.fontSize" = 12;
        "markdown.preview.fontFamily" = "'Hack Nerd Font', 'DejaVu Sans Mono', monospace";

        "python.analysis.diagnosticMode" = "workspace";
        "python.analysis.exclude" = [
          "**/result"
          "**/.direnv"
        ];

        "terminal.integrated.scrollback" = 5000;
        "terminal.integrated.fontSize" = 12;
        "terminal.integrated.defaultProfile.linux" = "bash";

        "update.mode" = "manual";

        "window.titleBarStyle" = "custom";
        "window.zoomLevel" = mkDefault 2;

        "workbench.colorTheme" = "Catppuccin Macchiato";
        "workbench.panel.defaultLocation" = "right";
        "workbench.startupEditor" = "readme";

        "[markdown]" = {
          "editor.defaultFormatter" = "yzhang.markdown-all-in-one";
        };
        "[nix]" = {
          "editor.tabSize" = 2;
        };
        "[python]" = {
          "editor.defaultFormatter" = "charliermarsh.ruff";
        };

        "evenBetterToml.formatter.arrayTrailingComma" = true;
        "evenBetterToml.formatter.arrayAutoExpand" = true;
      };
    };
  };
}
