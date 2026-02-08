{ lib, config, ... }: let cfg = config.audio; in {
    options = {
        audio.enable = lib.mkEnableOption "Enable Audio";
        audio.low-latency = lib.mkEnableOption "Enable Low Latency Audio";
    };

    config = let 
        pipewire = lib.mkIf cfg.enable {
            # Sound
            services.pulseaudio.enable = false;
            services.pipewire = {
                enable = true;
                audio.enable = true;
                alsa.enable = true;
                alsa.support32Bit = true;
                pulse.enable = true;
                jack.enable = true;
                wireplumber.enable = true;
                # Override the default config to set quantum size
            };
            security.rtkit.enable = true;
        };
        low-latency = lib.mkIf cfg.low-latency {
          services.pipewire.extraConfig.pipewire."92-low-latency" = {
            "context.properties" = {
              "default.clock.rate" = 96000;
              "default.clock.quantum" = 32;
              "default.clock.min-quantum" = 16;
              "default.clock.max-quantum" = 32;
            };
          };
          services.pipewire.extraConfig.pipewire-pulse."92-low-latency" = {
          context.modules = [
            {
              name = "libpipewire-module-protocol-pulse";
              args = {
                pulse.min.req = "16/96000";
                pulse.default.req = "32/96000";
                pulse.max.req = "32/96000";
                pulse.min.quantum = "16/96000";
                pulse.max.quantum = "32/96000";
              };
            }
          ];
          stream.properties = {
            node.latency = "32/96000";
            resample.quality = 1;
          };
        };
    };
    in lib.mkMerge [pipewire low-latency];
}
