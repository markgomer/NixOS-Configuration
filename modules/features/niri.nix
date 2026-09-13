{ ... }:
{
    flake.nixosModules.NiriModule = { pkgs-stable, pkgs-unstable, ... }: {
        programs.niri = {
            enable = true;
            package = pkgs-unstable.niri;
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
            pkgs-stable.alacritty # default terminal
            # NOTE: disabled in favor of noctalia plugin
            # pkgs-stable.hyprpolkitagent # or polkit_gnome
            pkgs-stable.wl-clipboard
            pkgs-stable.cliphist
            pkgs-stable.brightnessctl # laptop brightness
            pkgs-stable.nwg-look # GTK theme configurator
            pkgs-stable.pavucontrol # audio GUI fallback
            pkgs-stable.wayland-pipewire-idle-inhibit # idle inhibition
            pkgs-stable.playerctl # for using keyboard media keys
            pkgs-stable.ianny # break reminder program
            pkgs-stable.xwayland-satellite
            pkgs-stable.swaybg # wallpaper

            # screen tools plugin dependencies
            # TODO: is it still needed? This plugin is not available on v5
            pkgs-stable.grim
            pkgs-stable.slurp
            pkgs-stable.tesseract
            pkgs-stable.imagemagick
            pkgs-stable.zbar
            pkgs-stable.translate-shell
            pkgs-stable.wl-screenrec
            pkgs-stable.gifski
            pkgs-stable.jq
        ];
    };
}
