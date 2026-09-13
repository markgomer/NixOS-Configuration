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
            pkgs.wayland-pipewire-idle-inhibit # idle inhibition
            pkgs.playerctl # for using keyboard media keys
            pkgs.ianny # break reminder program
            pkgs.xwayland-satellite
            pkgs.swaybg # wallpaper
        ];
    };
}
