{
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    ./fzf.nix
    ./git.nix
    ./neovim.nix
    ./nix-index.nix
    ./ripgrep.nix
    ./thefuck.nix
    ./tmux
    ./zsh
  ];

  home = {
    username = "tuckershea";
    homeDirectory = lib.mkDefault "/home/tuckershea"; # fixme
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
    neofetch
    poetry
    sd
    tailscale
    wget
  ];
}
