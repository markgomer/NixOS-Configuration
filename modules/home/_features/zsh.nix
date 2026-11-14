{ config, lib, ... }:
{
    home.file.".zshenv".enable = lib.mkForce false;
    programs = {
        zsh = {
            enable = true;
            dotDir = "${config.home.homeDirectory}/.config/zsh";
            autosuggestion.enable = true;
            syntaxHighlighting.enable = true;
            enableCompletion = false;
            initContent = ''
                source $HOME/.config/zsh/init.sh
            '';
        };
        fzf = {
            enable = true;
            enableZshIntegration = true;
        };
    };
}
