{
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    ./fzf.nix
    ./git.nix
    ./jj.nix
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
    # Utilities
    cloc
    coreutils
    curl
    fd
    ffmpeg
    htop
    less
    neofetch
    openconnect
    pre-commit
    sd
    tailscale
    wget

    # hack to get this working sob
    # it doesn't work sob
    (pkgs.callPackage ../../../pkgs/jujutsu-unstable.nix {})

    # Languages and tooling
    poetry
    svlint
    texliveFull
    uv
    verilator
  ];

  programs.rbenv.enable = true;
  programs.rbenv.enableZshIntegration = true;
  programs.rbenv.plugins = 
        [
          {
            name = "ruby-build";
            src = pkgs.fetchFromGitHub {
              owner = "rbenv";
              repo = "ruby-build";
              rev = "v20250205";
              hash = "sha256-ZPULUkGkt7FkBTWygiky+QvMJPcslhWw3UPJ6XywfSU=";
            };
          }
        ];
}
