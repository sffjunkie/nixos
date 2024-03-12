{
  config,
  lib,
  pkgs,
  nix-vscode-extensions,
  ...
}: let
  cfg = config.looniversity.vscode;
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
    ms-vscode.makefile-tools
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

  marketplaceExtensionsList = with nix-vscode-extensions.extensions.${pkgs.system}.vscode-marketplace; [
    charliermarsh.ruff
    dlasagno.rasi
    executablebookproject.myst-highlight
    github.remotehub
    keesschollaart.vscode-home-assistant
    ms-vscode.cpptools-extension-pack
    ramyaraoa.show-offset
    rust-lang.rust-analyzer
    shipitsmarter.sops-edit
  ];
in {
  options.looniversity.vscode = {
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

        "editor.fontSize" = 12;
        "editor.fontFamily" = "'Hack Nerd Font Mono', 'monospace', monospace";
        "editor.tokenColorCustomizations" = {
          "[Nord]" = {
            "comments" = "#94b9a6";
          };
        };
        "editor.formatOnSave" = true;

        "editor.rulers" = [
          80
          100
        ];

        "explorer.confirmDragAndDrop" = false;
        "explorer.compactFolders" = false;

        "files.insertFinalNewline" = true;
        "files.exclude" = {
          "**/.tox" = true;
        };

        "git.confirmSync" = false;
        "git.openRepositoryInParentFolders" = "never";

        "terminal.integrated.scrollback" = 5000;
        "terminal.integrated.fontSize" = 12;
        "terminal.integrated.defaultProfile.linux" = "bash";

        "update.mode" = "manual";

        "window.titleBarStyle" = "custom";
        "window.zoomLevel" = mkDefault 2;

        "workbench.colorTheme" = "Nord";
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
      };
    };
  };
}
