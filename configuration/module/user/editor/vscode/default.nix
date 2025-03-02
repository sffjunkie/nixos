{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.looniversity.editor.vscode;
  inherit (lib) mkDefault mkEnableOption mkIf;

  vscodeExtensions = with pkgs.vscode-extensions; [
    arcticicestudio.nord-visual-studio-code
    jnoortheen.nix-ide
    bierner.markdown-mermaid
    brettm12345.nixfmt-vscode
    davidanson.vscode-markdownlint
    editorconfig.editorconfig
    donjayamanne.githistory
    dotjoshjohnson.xml
    fill-labs.dependi
    github.vscode-github-actions
    golang.go
    gruntfuggly.todo-tree
    humao.rest-client
    ms-python.python
    ms-python.vscode-pylance
    ms-vscode.makefile-tools
    ms-vscode-remote.remote-containers
    oderwat.indent-rainbow
    pkief.material-icon-theme
    shd101wyy.markdown-preview-enhanced
    stkb.rewrap
    tamasfe.even-better-toml
    timonwong.shellcheck
    twxs.cmake
    yzhang.markdown-all-in-one
    zxh404.vscode-proto3

    esbenp.prettier-vscode
    dbaeumer.vscode-eslint
    github.vscode-pull-request-github
  ];

  marketplaceExtensionsList =
    with inputs.nix-vscode-extensions.extensions.${pkgs.system}.vscode-marketplace; [
      catppuccin.catppuccin-vsc
      charliermarsh.ruff
      dlasagno.rasi
      executablebookproject.myst-highlight
      github.remotehub
      kennylong.kubernetes-yaml-formatter
      lencerf.beancount
      ms-vscode.cpptools-extension-pack
      ramyaraoa.show-offset
      rust-lang.rust-analyzer
      shipitsmarter.sops-edit
      skellock.just
      techer.open-in-browser
      tomphilbin.gruvbox-themes
      runem.lit-plugin
    ];
in
{
  options.looniversity.editor.vscode = {
    enable = mkEnableOption "vscode";
  };

  config = mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      package = pkgs.vscode.fhs;

      mutableExtensionsDir = true;
      profiles = {
        default = {
          extensions = vscodeExtensions ++ marketplaceExtensionsList;

          userSettings = {
            "cSpell.enabled" = false;

            "diffEditor.ignoreTrimWhitespace" = false;

            "editor.fontFamily" = mkIf (
              !config.stylix.targets.vscode.enable
            ) "'JetBrainsMono Nerd Font', 'DejaVu Sans Mono', monospace";
            "editor.fontSize" = mkIf (!config.stylix.targets.vscode.enable) 12;
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
              ".devenv" = true;
              ".direnv" = true;
            };

            "git.confirmSync" = false;
            "git.openRepositoryInParentFolders" = "never";

            "markdown.preview.fontSize" = mkIf (!config.stylix.targets.vscode.enable) 12;
            "markdown.preview.fontFamily" = mkIf (
              !config.stylix.targets.vscode.enable
            ) "'JetBrainsMono Nerd Font', 'DejaVu Sans Mono', monospace";

            "python.analysis.diagnosticMode" = "workspace";
            "python.analysis.exclude" = [
              "**/result"
              "**/.devenv"
              "**/.direnv"
            ];

            "terminal.integrated.scrollback" = 5000;
            "terminal.integrated.fontSize" = mkIf (!config.stylix.targets.vscode.enable) 12;
            "terminal.integrated.defaultProfile.linux" = "bash";

            "update.mode" = "manual";

            "window.titleBarStyle" = "custom";
            "window.zoomLevel" = mkDefault 2;

            "workbench.colorTheme" = mkIf (!config.stylix.targets.vscode.enable) "Catppuccin Macchiato";
            "workbench.panel.defaultLocation" = "right";
            "workbench.startupEditor" = "readme";

            "[markdown]" = {
              "editor.defaultFormatter" = "yzhang.markdown-all-in-one";
            };
            "[nix]" = {
              "editor.tabSize" = 2;
              "editor.defaultFormatter" = "brettm12345.nixfmt-vscode";
            };
            "[python]" = {
              "editor.defaultFormatter" = "charliermarsh.ruff";
            };
            "[jsonc]" = {
              "editor.defaultFormatter" = "vscode.json-language-features";
            };

            "evenBetterToml.formatter.arrayTrailingComma" = true;
            "evenBetterToml.formatter.arrayAutoExpand" = true;
          };
        };
      };
    };
  };
}
