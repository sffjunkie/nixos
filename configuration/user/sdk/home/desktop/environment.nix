{ config, sops, ... }:
{
  config = {
    sops.secrets."sdk/location/latitude" = {
      sopsFile = config.sopsFiles.user;
    };

    sops.secrets."sdk/location/longitude" = {
      sopsFile = config.sopsFiles.user;
    };

    sops.secrets."sdk/api_key/owm" = {
      sopsFile = config.sopsFiles.user;
    };

    sops.templates."qde_conf" = {
      content = ''
        USER_LOCATION_LATITUDE=${config.sops.placeholder."sdk/location/latitude"}
        USER_LOCATION_LONGITUDE=${config.sops.placeholder."sdk/location/longitude"}
        OWM_API_KEY=${config.sops.placeholder."sdk/api_key/owm"}
      '';
      owner = config.users.users.sdk.name;
    };

    home.file."environment.d/qde.conf".source = sops.templates."sdk_location".path;
  };
}
