{ pkgs, lib, ... }:
{
  programs.zsh = {
    enable = true;

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = lib.cleanSource ./.;
        file = "p10k.zsh";
      }
    ];

    oh-my-zsh = {
      enable = true;
      # theme = "powerlevel10k/powerlevel10k" set by zsh.plugins
      plugins = [
        "git"
        "autoenv"
        "bgnotify"
        "colored-man-pages"
        "command-not-found"
        "fzf"
        "poetry"
        "poetry-env"
        "pyenv"
        "rbenv"
        "thefuck"
        "tmux"
      ];
    };

    initExtraFirst =
    ''
      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]
; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi

      # No tmux in Jetbrains or when ssh'd into
      if [[ "$TERMINAL_EMULATOR" != "JetBrains-JediTerm" ]] && [[ -z "$SSH_CONNECTION" ]] then
        ZSH_TMUX_AUTOSTART='true'
      fi
    '';

    shellAliases = {
      ".." = "cd ..";
      "~" = "cd ~";
      "vi?" = "fzf --bind 'enter:become(nvim {})'";
      "cd?" = "cd \$(fd --type d --hidden --no-ignore | fzf)";
      "cd@" = "cd \$(fd --type f --hidden --no-ignore | fzf)";
    };
  };
}


