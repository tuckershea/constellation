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
    homeDirectory = lib.mkDefault "/home/tuckershea";
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
    wget
  ] ++ lib.optionals stdenv.isDarwin [
    pam-reattach
  ];
}
