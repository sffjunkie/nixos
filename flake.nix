{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    attic.url = "github:zhaofengli/attic";

    deploy-rs.url = "github:serokell/deploy-rs";
    deploy-rs.inputs.nixpkgs.follows = "nixpkgs";

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
    deploy-rs,
    disko,
    home-manager,
    nix-vscode-extensions,
    nixos-hardware,
    sops-nix,
    ...
  } @ inputs: let
    lib = nixpkgs.lib.extend (import ./lib {inherit lib inputs;});

    forAllSystems = nixpkgs.lib.genAttrs [
      "aarch64-linux"
      "x86_64-darwin"
      "x86_64-linux"
    ];

    hmCommonConfig = {
      config = {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {
          inherit nix-vscode-extensions;
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
          inherit lib disko;
        };

        modules = [
          ./configuration/machine/pinky
          ./configuration/user/sysadmin/machine

          sops-nix.nixosModules.sops
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
          inherit lib disko;
        };

        modules = [
          ./configuration/machine/thebrain
          ./configuration/user/sysadmin/machine

          sops-nix.nixosModules.sops
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
          inherit lib disko;
        };

        modules = [
          ./configuration/machine/furrball
          ./configuration/user/sdk/machine
          ./configuration/user/sysadmin/machine

          sops-nix.nixosModules.sops
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
          inherit lib disko;
        };

        modules = [
          ./configuration/machine/babs
          ./configuration/user/sysadmin/machine

          attic.nixosModules.atticd

          sops-nix.nixosModules.sops
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
          inherit lib disko;
        };

        modules = [
          ./configuration/machine/buster
          ./configuration/user/sdk/machine
          ./configuration/user/sysadmin/machine

          sops-nix.nixosModules.sops
          home-manager.nixosModules.default
          hmCommonConfig
          {
            config.home-manager.users.sdk =
              import ./configuration/user/sdk/home;
            # TODO: Fix sdk_buster
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
          inherit lib;
        };
        modules = [
          "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
          ./installer/looniversity-minimal.nix

          disko.nixosModules.disko
          {config.disko.enableConfig = false;}

          sops-nix.nixosModules.sops
          home-manager.nixosModules.default
          hmCommonConfig
          {config.home-manager.users.nixos = import ./configuration/user/nixos/home;}
        ];
      };
    };

    deploy = lib.deploy.mkDeploy {
      inherit (inputs) self;
      targets = ["babs"];
    };

    checks =
      builtins.mapAttrs
      (system: deployLib: deployLib.deployChecks self.deploy)
      deploy-rs.lib;

    # Generic development shells
    # The default 'nix' shell includes scripts to build nixos systems
    # using nix-ouptut-monitor
    devShells = forAllSystems (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      default = import ./devshell/nix {inherit pkgs;};
      go = import ./devshell/go {inherit pkgs;};
      python = import ./devshell/python {inherit pkgs;};
      rust = import ./devshell/rust {inherit pkgs;};
      net = import ./devshell/net {inherit pkgs;};
    });

    # The nix devShell above adds a nix-test function which runs the tests
    # under the `tests` attribute
    tests = lib.test.run {
      dir = ./test;
      inherit lib; # Needed by test functions
      # Optional attrs
      # include = ".*_test\.nix";
      # exclude = "";
      # quiet = false;
    };
  };
}
