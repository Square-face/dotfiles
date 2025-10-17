{config, ...}: {
    services.kanshi.enable = true;
    services.kanshi.settings = [
        {include = "${config.xdg.configHome}/kanshi/config.d/*";}
    ];
}
