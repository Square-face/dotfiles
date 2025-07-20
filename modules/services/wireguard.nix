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
    dns = {
      enable = mkEnableOption "Enable Shitcloud DNS for .sht domains";
      extraDNS = mkOption {
        type = types.listOf types.str;
        description = "Extra dns servers to use when not getting .sht domains";
        default = [
          "1.1.1.1"
          "8.8.8.8"
        ];
      };
    };
  };

  config = mkIf swg.enable {
    networking.wg-quick.interfaces = {
      wg0 = {
        address = [ "${swg.localIP}/24" ];
        privateKeyFile = swg.privateKeyFile;

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

    networking.nameservers = mkIf swg.dns.enable [ "127.0.0.1" ];

    services = mkIf swg.dns.enable {
      resolved.enable = false;

      dnsmasq = {
        enable = true;
        settings = {
          server = [ "/sht/10.10.10.1" ] ++ swg.dns.extraDNS;
          no-resolv = true;
          log-queries = false;
          log-facility = "/var/log/dnsmasq.log";
        };
      };
    };
  };
}
