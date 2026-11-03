{ ... }:
{
    flake.nixosModules.HyprModule = { pkgs, pkgs-unstable, ... }: {
        programs.hyprland = {
            enable = true;
            withUWSM = true;
            xwayland.enable = true;
            portalPackage = pkgs.xdg-desktop-portal-hyprland;
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
            pkgs-unstable.noctalia # legendary shell
            pkgs.kitty # we might get cooked without this
            # NOTE: disabled in favor of noctalia plugin
            # pkgs.hyprpolkitagent # or polkit_gnome
            pkgs.wl-clipboard
            pkgs.cliphist
            pkgs.brightnessctl # laptop brightness
            pkgs.nwg-look # GTK theme configurator
            pkgs.grimblast # screenshots
            pkgs.pavucontrol # audio GUI fallback
            pkgs.pulseaudio # for audio switching
            pkgs.playerctl # for using keyboard media keys
            pkgs.wayland-pipewire-idle-inhibit # idle inhibition
            pkgs-unstable.ianny # break reminder program
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
