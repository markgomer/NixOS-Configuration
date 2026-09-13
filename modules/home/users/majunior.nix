{ inputs, ... }:
{
    flake.nixosModules.majuniorHome = { pkgs-stable, pkgs-unstable, ... }: {
        imports = [
            inputs.home-manager.nixosModules.home-manager
        ];

        home-manager = {
            extraSpecialArgs = {
                inherit pkgs-stable;
                inherit pkgs-unstable;
            };
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "backup";

            users.majunior = { pkgs, pkgs-stable, pkgs-unstable, ... }: {
                imports = [
                    ../_features/zsh.nix
                ];

                home = {
                    username = "majunior";
                    homeDirectory = "/home/majunior";
                    packages = [
                        pkgs-unstable.asdf-vm
                        pkgs-stable.git
                        pkgs-stable.pokemon-colorscripts
                        pkgs-stable.tealdeer
                        pkgs-stable.tmux
                        pkgs-stable.eza
                        pkgs-stable.zoxide

                        pkgs-stable.distrobox
                        pkgs-stable.podman-compose

                        # coding pack
                        pkgs-stable.fd
                        pkgs-stable.lazygit
                        pkgs-stable.ripgrep
                        pkgs-stable.tree-sitter

                        pkgs-stable.nwg-look
                    ];

                    sessionVariables = {
                        EDITOR = "nvim";
                        TERM = "foot";
                        # gnome extensions gtk access
                        GI_TYPELIB_PATH = "/run/current-system/sw/lib/girepository-1.0";

                        # (hack to optimize noctalia-shell)
                        TZ = "America/Sao_Paulo";
                    };

                    stateVersion = "25.11";
                };

                programs.home-manager.enable = true;
            };
        };
    };
}
