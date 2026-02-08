{...}: {
    services.pcscd.enable = true;
    services.udisks2.enable = true;
    services.upower.enable = true;
    services.power-profiles-daemon.enable = true;


    security.pam.services.swaylock = {};
}
