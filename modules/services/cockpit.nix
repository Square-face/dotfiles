{pkgs, ...}:{
    environment.systemPackages = with pkgs; [
    cockpit];
    services.cockpit = {
        enable = true;
        port = 9090;
        openFirewall = true;
        allowed-origins = ["https://shrexbox:9090"];
        settings = {
            WebService = {
                AllowUnencrypted = true;
            };
        };
    };
}
