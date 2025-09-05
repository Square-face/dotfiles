{...}: {
    services.kanshi.enable = true;

    services.kanshi.settings = [
        {include = "config.d/*";}
        {
            profile.name = "PC";
            profile.outputs = [
                {
                    criteria = "Lenovo Group Limited 0x1144 VM-06485";
                    transform = "90";
                    position = "2560,600";
                }
                {
                    criteria = "Samsung Electric Company S24D340 0x30343238";
                    position="640,0";
                }
                {
                    criteria = "Philips Consumer Electronics Company Philips 272P4 AU41344000763";
                    position="0,1080";
                }
            ];
        }
    ];
}
