{
  config,
  pkgs,
  sops,
  ...
}: {
  config = {
    # https://github.com/Mic92/sops-nix#setting-a-users-password
    sops.secrets."nixos/password_hash" = {
      neededForUsers = true;
      sopsFile = config.sopsFiles.user;
    };

    users.users.nixos = {
      isNormalUser = true;
      uid = 1100;
      extraGroups = ["networkmanager" "wheel"];
      openssh = {
        authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA8Ayl5f2l+BFrUTzbyzmiLbhmYzTaLptCwe80Vk84NJ nixos"
        ];
      };
      hashedPasswordFile = config.sops.secrets."nixos/password_hash".path;
    };

    services.openssh.settings.AllowUsers = ["nixos"];
  };
}
