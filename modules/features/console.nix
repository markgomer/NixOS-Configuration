{ config, pkgs, ... }: {
flake.nixosModules.ConsoleModule = { pkgs, pkgs-unstable, config, ... }: {
    imports = [
        /etc/nixos/hardware-configuration.nix
    ];

    # 1. Bootloader & Kernel Configuration
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # 2. Networking
    networking.hostName = "nix-arcade";
    networking.networkmanager.enable = true;

    # 3. User Account & Auto-Login
    users.users.arcade = {
        isNormalUser = true;
        description = "Arcade Kiosk User";
        extraGroups = [ "networkmanager" "wheel" "video" "audio" "input" ];
    };

    # 4. Clamshell Laptop Lid Settings (Ignore Close)
    services.logind = {
        lidSwitch = "ignore";
        lidSwitchExternalPower = "ignore";
        lidSwitchDocked = "ignore";
    };

    # 5. Display Manager & Desktop Session Setup
    services.displayManager = {
        sddm = {
            enable = true;
            wayland.enable = true;
        };
        autoLogin = {
            enable = true;
            user = "arcade";
        };
        # Custom Wayland Session for ES-DE
        sessionPackages = [
            (pkgs.runCommand "es-de-gamescope-session" {
              passthru.providedSessions = [ "es-de-gamescope" ];
            } ''
              mkdir -p $out/share/wayland-sessions
              cat <<'EOF' > $out/share/wayland-sessions/es-de-gamescope.desktop
              [Desktop Entry]
              Name=EmulationStation (Gamescope)
              Comment=Boot straight into ES-DE kiosk mode
              Exec=gamescope -f -W 1920 -H 1080 --prefer-vk-device 10de:* -- es-de
              Type=Application
              EOF
            '')
          ];
    };

    # Secondary Desktop Environment for switching back
    services.desktopManager.plasma6.enable = true;

    # 6. Graphics & NVIDIA Drivers
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.graphics = {
        enable = true;
        enable32Bit = true;
    };
    hardware.nvidia = {
        modesetting.enable = true;
        open = false; # Set to true if on RTX 2000 / GTX 1600 or newer
        nvidiaSettings = true;
    };

    # 7. Gamescope & Bluetooth / Controllers
    programs.gamescope = {
        enable = true;
        capSysNice = true;
    };

    hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
    };
    hardware.xpadneo.enable = true; # Xbox pad support over Bluetooth
    services.joycond.enable = true; # Switch controller support

    # Automount external USB storage
    services.udisks2.enable = true;

    # 8. Packages & Emulators
    environment.systemPackages = with pkgs; [
        # Frontend & Core
        emulationstation-de
        retroarchFull

        # Standalone Emulators
        pcsx2
        rpcs3
        dolphin-emu

        # System Utilities
        bluez
        bluez-tools
        ffmpeg
    ];

    # 9. NixOS System Version
    system.stateVersion = "26.05"; # Match your installed NixOS release version
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nixpkgs.config.allowUnfree = true;
};
}
