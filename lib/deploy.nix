{
  lib,
  config,
  deploy-rs,
  ...
}: let
  domaninName = config.looniversity.network.domainName;
in {
  deployNodes = hosts:
    lib.listToAttrs (map (host:
      lib.nameValuePair host
      {
        hostname = "${host}.${domaninName}";
        profiles.system = {
          user = config.users.users.sysadmin.name;
          path = deploy-rs.lib.${system}.activate.nixos self.nixosConfigurations.${host};
        };
      })
    hosts);
}
