{ config, pkgs, lib, ... }:
{
  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    cloc
    coreutils
    curl
    fd
    ffmpeg
    neofetch
    poetry
    # pyenv below
    # rbenv below
    wget
  ] ++ lib.optionals stdenv.isDarwin [
    pam-reattach 
  ];

  home.shellAliases = {
    ".." = "cd ..";
    "~" = "cd ~";
    "\"vi?\"" = "fzf --bind 'enter:become(nvim {})'";
    "\"cd?\"" = "cd \$(fd --type d --hidden --no-ignore | fzf)";
    "\"cd@\"" = "cd \$(fd --type f --hidden --no-ignore | fzf)";
  };

  home.sessionVariables = {
    
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
        src = lib.cleanSource ./zsh;
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
    prefix = "C-s";
    historyLimit = 10000;

    extraConfig = lib.strings.concatLines [
      (builtins.readFile tmux/tmux.conf)
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

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = "fd --type f --hidden --no-ignore";
    fileWidgetCommand = "fd --type f --hidden --no-ignore";
    # fileWidgetOptions = [ "--preview='head -200 {}'" ];
    changeDirWidgetCommand = "fd --type d --hidden --no-ignore";
    # changeDirWidgetOptions = [ "--preview='tree -C {} | head -200'" ];
    # tmux.enableShellIntegration = true;
  };

  programs.git = {
    enable = true;
    delta.enable = true;
    hooks = {
      # pre-commit = ./../pre-commit-script;
    };
    ignores = [
      "*.swp"
      ".DS_Store"
      "._.DS_Store"
      "**/.DS_Store"
      "**/._.DS_Store"
    ];
    signing = {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMh3wNTGjXPzrHWZI1ZZfoRg3w6osDeB1VUYSaRd5Dk9";
      signByDefault = true;
    };
    userEmail = "tucker@tuckershea.com";
    userName = "NoRePercussions";
    extraConfig = {
      gpg.format = "ssh";
      core.autocrlf = "input";
      init.defaultBranch = "main";
      "gpg \"ssh\"".program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
    };
  };

  programs.htop.enable = true;

  programs.less.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      vim-nix
      dracula-nvim
      # get some plugins
    ];
    viAlias = true;
    vimAlias = true;
  };

  programs.pyenv = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.pylint.enable = true;

  programs.rbenv = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.tealdeer = {
    enable = true;
    settings.updates.auto_update = true;
  };

  programs.thefuck = {
    enable = true;
    enableZshIntegration = true;
    # enableInstantMode = true;
  };

  # caffeine-ng not currently supported on macos
  # will have to use brew keepingyouawake instead
  # or look further into
  # services.caffeine.enable = true;
}
