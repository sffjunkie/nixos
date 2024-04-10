{
  imports = [
    ../../common
  ];

  config = {
    programs.home-manager.enable = true;

    home = {
      username = "sysadmin";
      homeDirectory = "/home/sysadmin";
      stateVersion = "23.05";

      sessionVariables = {
        VAULT_ADDR = "http://thebrain.looniversity.net:8200";
      };
    };
    stylix.autoEnable = false;
  };
}
