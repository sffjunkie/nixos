{lib, ...}: {
  deployNodes = hosts:
    pkgs.lib.listToAttrs (map (host:
      pkgs.lib.nameValuePair host
      {
        hostname = "${host}.brage.info";
        profiles.system = {
          user = "root";
          path = deploy-rs.lib.${system}.activate.nixos self.nixosConfigurations.${host};
        };
      })
    hosts);
}
