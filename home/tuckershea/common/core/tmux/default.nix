{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.tmux = {
    enable = true;
    clock24 = true;
    keyMode = "vi";
    mouse = true;
    prefix = "C-s";
    historyLimit = 10000;
    terminal = "tmux-256color";

    extraConfig = lib.mkMerge [
      (builtins.readFile ./tmux.conf)
      "set-option -g repeat-time 0"
      # True color
      # https://gist.github.com/andersevenrud/015e61af2fd264371032763d4ed965b6
      "set -ag terminal-overrides \",*:RGB\""
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
