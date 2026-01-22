{...}: {
    services.pcscd.enable = true;
    services.udisks2.enable = true;


    security.pam.services.swaylock = {};
}
