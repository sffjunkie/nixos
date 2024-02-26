{
  config,
  lib,
  pkgs,
  ...
}: let
  script = pkgs.writeScriptBin "nixos-system" ''
    #!${lib.getExe pkgs.bash}
    VALID_ARGS=$(getopt -o sv --long show-trace,verbose -- "''$@")
    if [[ $? -ne 0 ]]; then
        exit 1;
    fi

    extra_args=()
    eval set -- "$VALID_ARGS"
    while [ : ]; do
      case "$1" in
        -v | --verbose)
            extra_args+=("--verbose")
            shift
            ;;
        -s | --show-trace)
            extra_args+=("--show-trace")
            shift
            ;;
        --) shift;
            break
            ;;
      esac
    done

    if [ -z "$2" ]; then
      target="$(hostname)"
    else
      target="$2"
    fi

    COLUMNS=$(tput cols)
    case "$1" in
      build)
        ${pkgs.figlet}/bin/figlet \
          -d "${pkgs.figlet}/share/figlet" \
          -f doom \
          -w "''${COLUMNS}" \
          "$target  :  build"

        nixos-rebuild build --flake ".#''${target}" \
          --impure --log-format internal-json "''${extra_args[@]}" |& \
          ${pkgs.nix-output-monitor}/bin/nom --json
        ;;

      dry-build)
        ${pkgs.figlet}/bin/figlet \
          -d "${pkgs.figlet}/share/figlet" \
          -f doom \
          -w "''${COLUMNS}" \
          "$target  :  dry build"

        nixos-rebuild dry-build --flake ".#''${target}" \
          --impure --log-format internal-json "''${extra_args[@]}" |& \
          ${pkgs.nix-output-monitor}/bin/nom --json
        ;;

      switch)
        sudo ${pkgs.figlet}/bin/figlet \
          -d "${pkgs.figlet}/share/figlet" \
          -f doom \
          -w "''${COLUMNS}" \
          "$target  :  build + switch"

        sudo nixos-rebuild switch --flake ".#''${target}" \
          --impure --log-format internal-json "''${extra_args[@]}" |& \
          ${pkgs.nix-output-monitor}/bin/nom --json
        ;;

      *)
        [ $# -eq 0 ] && echo -n "No mode specified. "
        echo "Mode must be one of 'build', 'build-vm' or 'switch'"
        exit 1
        ;;
    esac
  '';
in
  script
