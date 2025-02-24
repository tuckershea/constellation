{
  pkgs,
  lib,
  ...
}: {
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
      {
        name = "vi-mode";
        src = pkgs.zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
    ];

    oh-my-zsh = {
      enable = true;
      # theme = "powerlevel10k/powerlevel10k" set by zsh.plugins
      plugins = [
        "git"
        "bgnotify"
        "colored-man-pages"
        "command-not-found"
        "fzf"
        "pyenv"
        "rbenv"
      ];
    };

    initExtraFirst = ''
      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi

      . "$HOME/.cargo/env"
    '';

    sessionVariables = {
      KUBECONFIG = "~/.kube/config";
    };

    shellAliases = {
      ".." = "cd ..";
      "~" = "cd ~";
      "vi?" = "fzf --bind 'enter:become(nvim {})'";
      "cd?" = "cd \$(fd --type d --hidden --no-ignore | fzf)";
      "cd@" = "cd \$(fd --type f --hidden --no-ignore | fzf)";

      "nb" = "nix build";
      "nd" = "nix develop";
      "nf" = "nix flake";
      "nfc" = "nix flake check";
      "nfl" = "nix flake lock";
      "nr" = "nix run";
      "ns" = "nix shell";

      "nosf" = "nixos-rebuild switch --flake";
      "dsf" = "darwin-rebuild switch --flake";

      # ga, gp, already aliased by...something.
      # Probably git zsh plugin
      "gs" = "git status";
      "gre" = "git reset";
      "grb" = "git rebase";

      "k" = "kubectl";
      "kg" = "kubectl get";
      "kd" = "kubectl describe";
      "ka" = "kubectl apply";
    };
  };
}
