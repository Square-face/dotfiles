{ ... }:
{
  programs.kitty.enable = true;
  programs.kitty.settings = {
    font_family = "FiraCode Nerd Font Mono";
    font_size = 10;
    disable_ligatures = "never";
    background_opacity = 0.8;
    # background_image = builtins.toString ../../assets/frieren_sniper.jpg;
    # background_image_layout = "cscaled";
    background_tint = 0.8;
    allow_remote_control = "socket-only";
    listen_on = "unix:/tmp/kitty";
    macos_option_as_alt = true;
  };
}
