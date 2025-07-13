{
  config,
  lib,
  ...
}:

with lib;

let
  swg = config.wg.shitcloud;
in
{
  options.wg.shitcloud = {
    enable = mkEnableOption "Enable WireGuard interface";
    localIP = mkOption {
      type = types.str;
      example = "10.10.10.101/24";
      description = "The local IP address of this WireGuard peer.";
    };
    privateKeyFile = mkOption {
      type = types.path;
      description = "Path to the WireGuard private key file.";
      default = "/opt/wireguard/private.key";
    };
  };

  config = mkIf swg.enable {
    networking.wg-quick.interfaces = {
      wg0 = {
        address = [ "${swg.localIP}/24" ];
        privateKeyFile = swg.privateKeyFile;
        dns = [ "10.10.10.1" ];

        peers = [
          {
            publicKey = "J1F+7yaCc7iues5fqxT9XFxxzg1WfoiyWb0hKDhHghg=";
            allowedIPs = [ "10.10.10.0/24" ];
            endpoint = "193.234.117.50:41195";
            persistentKeepalive = 25;
          }
        ];
      };
    };
  };
}
