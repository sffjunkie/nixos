# Looniversity Nixos Configurations

- configuration
  - machine - per machine configurations
  - module - various nixos modules
    - home - home-manager modules
    - machine - machine wide modules
    - mount - mount points
  - role - a role enables a group of modules
  - secret - sops-nix secrets
  - site - site wide configuration
    - network - hosts, services, serviceHandlers
    - tool - tools
  - user - user definitions
    - *user name*
      - home - home-manager configuration
      - machine - system user database configuration

- devshell - Dev shells for various programming languages and
  managing nixos targets.

- disko - Various disko layouts

- installer - ISO installation image creation

- lib - custom library functions
  - network - Retrieve values from the site.network configuration
  - tool - Retrieve tool information from the site.tool configuration

## devshell

Generic programming language shells to be used for exploration.

nix - includes a set of tools to work with nix and nixpkgs as well as
various custom scripts to build nixos systems, installer ISO and VMs.

## disko

[disko](https://github.com/nix-community/disko) configurations for...

- one disk with `/boot` EFI partition and a ZFS pool for root, `/nix` and `/home`.
- two disks
  - one disk with `/boot` EFI partition and a ZFS pool for root and `/nix`
  - a second disk with a ZFS pool for `/home`
- 3 disks
  - one disk with `/boot` EFI partition and a ZFS pool for root and `/nix`
  - second and third disks with a ZFS mirror pool for `/home`

## To Do

- Unit tests for the custom lib functions.
- Complete the machines
  - pinky
  - thebrain
- Add required services (and delete those not required.)
