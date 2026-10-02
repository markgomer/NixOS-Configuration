{ inputs, ... }:
{
    flake.nixosModules.majuniorHome = { pkgs-unstable, ... }: {
        imports = [
            inputs.home-manager.nixosModules.home-manager
        ];

        home-manager = {
            extraSpecialArgs = {
                inherit pkgs-unstable;
            };
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "backup";

            users.majunior = { pkgs, pkgs-unstable, ... }: {
                imports = [
                    ../_features/zsh.nix
                ];

                home = {
                    username = "majunior";
                    homeDirectory = "/home/majunior";
                    packages = [
                        pkgs-unstable.asdf-vm # to setup dev envs
                        pkgs.git
                        pkgs.pokemon-colorscripts # the real reason i only use the terminal
                        pkgs.tealdeer # tldr to bypass boring documentation
                        pkgs.tmux # CHAD PROGRAMMER tool
                        pkgs.eza # pretty ls. I like it
                        pkgs.zoxide # better cd. Used with yazi (?)

                        pkgs.distrobox # use arch when things get ugly on nixos
                        pkgs.podman-compose # projects' container management

                        # neovim coding pack
                        pkgs.fd # find files on neovim
                        pkgs.lazygit # TUI git, activated on neovim
                        pkgs.ripgrep # neovim grep
                        pkgs.tree-sitter # semantic highlighting on neovim

                        pkgs.nwg-look # select GTK theme
                    ];

                    sessionVariables = {
                        EDITOR = "nvim";
                        TERM = "foot";
                        # gnome extensions gtk access
                        GI_TYPELIB_PATH = "/run/current-system/sw/lib/girepository-1.0";

                        # (hack to optimize noctalia-shell)
                        TZ = "America/Sao_Paulo";
                    };

                    stateVersion = "26.05";
                };

                programs.home-manager.enable = true;
            };
        };
    };
}
