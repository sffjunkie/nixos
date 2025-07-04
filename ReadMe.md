# Looniversity Nixos Configurations

- configuration
  - host - per host configurations

  - module - various nixos modules
    - home - home-manager modules
    - host - host modules

  - overlay

  - role - a role enables a group of modules

  - secret - sops-nix secrets

  - user - user definitions
    - *user_name*
      - home - home-manager configuration
      - host - system user configuration

  - var - site wide configuration

- devshell - Dev shells for various programming languages and
  managing nixos targets.

- installer - ISO installation image creation

- lib - custom library functions
  - ipv4 - Functions to manipulate IPv4 addresses
  - network - Retrieve values from the site.network configuration
  - tool - Retrieve tool information from the site.tool configuration
  - test - Provides a `run` function to run unit tests

- template
  - disko - Various disko layouts

- test - Functions to custom library functions. Uses `lib.test.run` to execute them.

## devshell

Generic programming language shells to be used for exploration.

nix - includes a set of tools to work with nix and nixpkgs as well as
various custom scripts to build nixos systems, installer ISO and VMs.

## disko templates

[disko](https://github.com/nix-community/disko) configurations for...

- one disk with `/boot` EFI partition and an ext4 filesystem for `/`.

- one disk with `/boot` EFI partition and a ZFS pool for root, `/nix` and `/home`.

- two disks
  - one disk with `/boot` EFI partition and a ZFS pool for root and `/nix`
  - a second disk as a ZFS pool for `/home`

- 3 disks
  - one disk with `/boot` EFI partition and a ZFS pool for root and `/nix`
  - second and third disks as a ZFS mirror pool for `/home`

## To Do

- [ ] Unit tests for the custom lib functions.
- [ ] Complete the machines
  - [ ] pinky
  - [ ] thebrain
- [ ] Add required services (and delete those not required?)
