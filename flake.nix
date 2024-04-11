{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    attic.url = "github:zhaofengli/attic";

    deploy-rs.url = "github:serokell/deploy-rs";
    deploy-rs.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    sops-nix.url = "github:Mic92/sops-nix";

    stylix.url = "github:danth/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";
  };

  nixConfig = {
    bash-prompt = ''\n\[\033[1;34m\][\[\e]0;\u@\h: \w\a\]\u@\h:\w]\\$\[\033[0m\] '';
  };

  outputs = {
    self,
    nixpkgs,
    attic,
    deploy-rs,
    home-manager,
    nixos-hardware,
    sops-nix,
    stylix,
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
          inherit inputs;
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
          inherit lib;
        };

        modules = [
          ./configuration/machine/pinky
          ./configuration/user/sysadmin/machine
          {
            config.home-manager.users.sysadmin = import ./configuration/user/sysadmin/home;
          }

          home-manager.nixosModules.default
          hmCommonConfig
          sops-nix.nixosModules.sops
        ];
      };

      # Services
      thebrain = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit lib;
        };

        modules = [
          ./configuration/machine/thebrain
          ./configuration/user/sysadmin/machine
          {
            config.home-manager.users.sysadmin = import ./configuration/user/sysadmin/home;
          }

          home-manager.nixosModules.default
          hmCommonConfig
          sops-nix.nixosModules.sops
        ];
      };

      # Workstation
      furrball = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit lib inputs;
        };

        modules = [
          ./configuration/machine/furrball
          ./configuration/user/sdk/machine
          ./configuration/user/sysadmin/machine
          {
            config.home-manager.users.sdk = import ./configuration/user/sdk/home;
            config.home-manager.users.sysadmin = import ./configuration/user/sysadmin/home;
          }

          home-manager.nixosModules.default
          hmCommonConfig
          nixos-hardware.nixosModules.common-pc
          nixos-hardware.nixosModules.common-pc-ssd
          sops-nix.nixosModules.sops
          stylix.nixosModules.stylix
        ];
      };

      # Storage
      babs = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit lib;
        };

        modules = [
          ./configuration/machine/babs
          ./configuration/user/sysadmin/machine

          attic.nixosModules.atticd
          {
            config.home-manager.users.sysadmin = import ./configuration/user/sysadmin/home;
          }

          home-manager.nixosModules.default
          hmCommonConfig
          nixos-hardware.nixosModules.common-pc
          nixos-hardware.nixosModules.common-pc-ssd
          sops-nix.nixosModules.sops
        ];
      };

      # Laptop
      buster = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit lib;
        };

        modules = [
          ./configuration/machine/buster
          ./configuration/user/sdk/machine
          ./configuration/user/sysadmin/machine
          {
            config.home-manager.users.sdk =
              import ./configuration/user/sdk/home;
            # TODO: Fix sdk_buster
            # // (import ./configuration/user/sdk_buster/home);
            config.home-manager.users.sysadmin = import ./configuration/user/sysadmin/home;
          }

          home-manager.nixosModules.default
          hmCommonConfig
          nixos-hardware.nixosModules.microsoft-surface-pro-intel
          sops-nix.nixosModules.sops
          stylix.nixosModules.stylix
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
          {
            config.home-manager.users.nixos = import ./configuration/user/nixos/home;
          }

          home-manager.nixosModules.default
          hmCommonConfig
          sops-nix.nixosModules.sops
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
