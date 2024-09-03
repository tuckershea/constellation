{
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    inputs.nix-index-database.hmModules.nix-index

    ./fzf.nix
    ./git.nix
    ./neovim.nix
    ./pyenv.nix
    ./surfingkeys
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

  programs.ripgrep = {
    enable = true;
    arguments = [
      "--max-columns=150"
      "--smart-case"
    ];
  };

  programs.nix-index-database.comma.enable = true;
}
