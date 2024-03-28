{
  lib,
  config,
  ...
}: let
  domaninName = config.looniversity.network.domainName;
in {
  deployNodes = hosts:
    pkgs.lib.listToAttrs (map (host:
      pkgs.lib.nameValuePair host
      {
        hostname = "${host}.${domaninName}";
        profiles.system = {
          user = config.users.users.sysadmin.name;
          path = deploy-rs.lib.${system}.activate.nixos self.nixosConfigurations.${host};
        };
      })
    hosts);
}
