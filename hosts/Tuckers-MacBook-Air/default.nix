{ pkgs, ... }:
{
  # Auto-upgrade by always running daemon
  services.nix-daemon.enable = true;

  nix.settings.experimental-features = "nix-command flakes";

  # zsh with nix
  programs.zsh.enable = true;

  homebrew = {
    enable = true;
    onActivation.autoUpdate = true;
    casks = [

    ];
  };

  system.defaults = {

  };

  system.stateVersion = 4;

  users.users.tuckershea.home = "/Users/tuckershea";

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.tuckershea = { pkgs, ... }: {

    home.stateVersion = "23.11";

#    programs.tmux = { # my tmux configuration, for example
#      enable = true;
#      keyMode = "vi";
#      clock24 = true;
#      historyLimit = 10000;
#      plugins = with pkgs.tmuxPlugins; [
#        vim-tmux-navigator
#        gruvbox
#      ];
#      extraConfig = ''
#        new-session -s main
#        bind-key -n C-a send-prefix
#      '';
#    };
  };
}
