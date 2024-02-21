{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    attic.url = "github:zhaofengli/attic";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    sops-nix.url = "github:Mic92/sops-nix";
  };

  nixConfig = {
    bash-prompt = ''\n\[\033[1;34m\][\[\e]0;\u@\h: \w\a\]\u@\h:\w]\\$\[\033[0m\] '';
  };

  outputs = {
    self,
    nixpkgs,
    attic,
    disko,
    home-manager,
    nix-vscode-extensions,
    nixos-hardware,
    sops-nix,
    ...
  } @ inputs: let
    lib = nixpkgs.lib.extend (import ./lib {inherit lib;});

    hmCommonConfig = {
      config = {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {
          inherit nix-vscode-extensions sops-nix;
        };
        home-manager.sharedModules = [
          sops-nix.homeManagerModules.sops
        ];
      };
    };
  in {
    nixosConfigurations = {
      # Security
      pinky = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit lib sops-nix disko;
        };

        modules = [
          ./configuration/machine/pinky
          ./configuration/user/sysadmin/machine

          home-manager.nixosModules.default
          hmCommonConfig
          {
            config.home-manager.users.sysadmin = import ./configuration/user/sysadmin/home;
          }
        ];
      };

      # Services
      thebrain = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit lib sops-nix disko;
        };

        modules = [
          ./configuration/machine/thebrain
          ./configuration/user/sysadmin/machine

          home-manager.nixosModules.default
          hmCommonConfig
          {
            config.home-manager.users.sysadmin = import ./configuration/user/sysadmin/home;
          }
        ];
      };

      # Workstation
      furrball = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit lib sops-nix disko;
        };

        modules = [
          ./configuration/machine/furrball
          ./configuration/user/sdk/machine
          ./configuration/user/sysadmin/machine

          home-manager.nixosModules.default
          hmCommonConfig
          {
            config.home-manager.users.sdk = import ./configuration/user/sdk/home;
            config.home-manager.users.sysadmin = import ./configuration/user/sysadmin/home;
          }

          nixos-hardware.nixosModules.common-pc
          nixos-hardware.nixosModules.common-pc-ssd
        ];
      };

      # Storage
      babs = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit lib sops-nix disko;
        };

        modules = [
          ./configuration/machine/babs
          ./configuration/user/sysadmin/machine

          attic.nixosModules.atticd

          home-manager.nixosModules.default
          hmCommonConfig
          {
            config.home-manager.users.sysadmin = import ./configuration/user/sysadmin/home;
          }

          nixos-hardware.nixosModules.common-pc
          nixos-hardware.nixosModules.common-pc-ssd
        ];
      };

      # Laptop
      buster = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit lib sops-nix disko;
        };

        modules = [
          ./configuration/machine/buster
          ./configuration/user/sdk/machine
          ./configuration/user/sysadmin/machine

          home-manager.nixosModules.default
          hmCommonConfig
          {
            config.home-manager.users.sdk =
              # TODO: Fix sdk_buster
              import ./configuration/user/sdk/home;
            # // (import ./configuration/user/sdk_buster/home);
            config.home-manager.users.sysadmin = import ./configuration/user/sysadmin/home;
          }

          nixos-hardware.nixosModules.microsoft-surface-pro-intel
        ];
      };

      # Installer ISO
      installer = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit lib sops-nix;
        };
        modules = [
          "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
          ./installer/looniversity-minimal.nix

          disko.nixosModules.disko
          {config.disko.enableConfig = false;}

          home-manager.nixosModules.default
          hmCommonConfig
          {config.home-manager.users.nixos = import ./configuration/user/nixos/home;}
        ];
      };
    };

    # Generic development shells
    # The default 'nix' shell includes scripts to build systems
    # using nix-ouptut-monitor
    devShells.x86_64-linux = let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in {
      default = import ./devshell/nix {inherit pkgs;};
      go = import ./devshell/go {inherit pkgs;};
      python = import ./devshell/python {inherit pkgs;};
      rust = import ./devshell/rust {inherit pkgs;};
      net = import ./devshell/net {inherit pkgs;};
    };
  };
}
