{
    virtualisation.docker.enable = true;

    home.sessionVariables = {
        DOCKER_CONFIG = "${config.xdg.configHome}/docker";
    };
}
