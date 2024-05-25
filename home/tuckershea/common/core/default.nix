{ pkgs, lib, ... }:
{
  imports = [
    ./fzf.nix
    ./git.nix
    ./neovim.nix
    ./pyenv.nix
    ./rbenv.nix
    ./thefuck.nix
    ./tmux
    ./zsh
  ];

  home = {
    username = "tuckershea";
    homeDirectory = lib.mkDefault "/home/tuckershea";  # fixme
    stateVersion = lib.mkDefault "23.11";

    sessionVariables = {
      EDITOR = "nvim";
    };
  };

  home.packages = with pkgs; [
    cloc
    coreutils
    curl
    fd
    ffmpeg
    htop
    less
    ncdu
    neofetch
    poetry
    sd
    tailscale
    wget
  ];

  programs.ripgrep = {
    enable = true;
    arguments = [
      "--max-columns=150"
      "--smart-case"
    ];
  };
}
