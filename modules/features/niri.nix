{ ... }:
{
    flake.nixosModules.NiriModule = { pkgs, pkgs-unstable, ... }: {
        programs.niri = {
            enable = true;
            package = pkgs.niri;
            useNautilus = true;
        };
        services = {
            power-profiles-daemon.enable = true;
            upower.enable = true; # Battery status
            gnome.gnome-keyring.enable = true;
            logind = {
                settings = {
                    Login = {
                        HandleLidSwitchDocked = "ignore";
                        HandleLidSwitchExternalPower = "ignore";
                        HandleLidSwitch = "ignore";
                    };
                };
            };
        };
        environment.systemPackages = [
            pkgs-unstable.noctalia # beta version
            pkgs.alacritty # default terminal
            pkgs.wl-clipboard
            pkgs.cliphist
            pkgs.brightnessctl # laptop brightness
            pkgs.nwg-look # GTK theme configurator
            pkgs.pavucontrol # audio GUI fallback
            pkgs.pulseaudio # for audio switching
            pkgs-unstable.wayland-pipewire-idle-inhibit # idle inhibition
            pkgs.playerctl # for using keyboard media keys
            pkgs-unstable.ianny # break reminder program
            pkgs-unstable.xwayland-satellite
            pkgs.swaybg # wallpaper
            # screen toolkit noctalia plugin
            pkgs-unstable.slurp # region selection
            pkgs-unstable.grim # screen capt
            pkgs-unstable.hyprpicker # color pick
            pkgs-unstable.imagemagick # image processing
            pkgs-unstable.zbar # qr barcode scanning
            pkgs-unstable.bc # GIF duration and framrate calculations
            pkgs-unstable.mpv
        ];
    };
}
