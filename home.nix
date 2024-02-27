{ config, pkgs, lib, ... }:
{
  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    coreutils
    curl
    wget
  ] ++ lib.optionals stdenv.isDarwin [
  
  ];

  home.shellAliases = {
    ".." = "cd ..";
    "~" = "cd ~";
    "vi" = "nvim";
    "\"vi?\"" = "fzf --bind 'enter:become(nvim {})'";
    "\"cd?\"" = "cd \$(fd --type d --hidden --no-ignore | fzf)";
    "\"cd@\"" = "cd \$(fd --type f --hidden --no-ignore | fzf)";
  };

  programs.zsh = {
    enable = true;

    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = lib.cleanSource ./p10k-config;
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
	"copyfile"
	"copypath"
	"fancy-ctrl-z"
	"fzf"
	"poetry"
	"poetry-env"
	"pyenv"
	"rbenv"
	"thefuck"
	"tmux"
	"web-search"
	# "zsh-autosuggestions"
	# "zsh-syntax-highlighting"
      ];
    };

    initExtraFirst =
    ''
      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi
      if [[ "$TERMINAL_EMULATOR" != "JetBrains-JediTerm" ]] then
        ZSH_TMUX_AUTOSTART='true'
      fi
    '';
  };

  programs.tmux = {
    enable = true;
    clock24 = true;
    keyMode = "vi";
    mouse = true;
    # prefix = "C-s"; Set by extraConfig
    historyLimit = 10000;

    extraConfig = lib.strings.concatLines [
      (builtins.readFile tmux-config/tmux.1.conf)
      #(builtins.readFile tmux-config/tmux.2.conf)
      #(builtins.readFile tmux-config/tmux.3.conf)
      ''
        unbind C-a
        unbind C-b
        set -g prefix C-s
        bind C-s send-prefix
      ''
    ];

    plugins = with pkgs; [
      tmuxPlugins.copycat
      tmuxPlugins.yank
      tmuxPlugins.resurrect
      {
        plugin = tmuxPlugins.continuum;
	extraConfig = ''
	  set -g @continuum-save-interval '5'
          set -g @continuum-restore 'on'
	'';
      }
      {
        plugin = tmuxPlugins.better-mouse-mode;
	extraConfig = ''
	  set-option -g mouse on
          set -g @scroll-without-changing-pane 'on'
          set -g @scroll-speed-num-lines-per-scroll '1'
          set -g @emulate-scroll-for-no-mouse-alternate-buffer 'on'
	'';
      }
      {
        plugin = tmuxPlugins.dracula;
        extraConfig = ''
	  set -g @dracula-show-powerline true
	  set -g @dracula-refresh-rate 10
	'';
      }
    ];
  };
}
