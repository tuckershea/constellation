{
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    ./atuin
    ./fzf.nix
    ./git.nix
    ./jj
    ./neovim.nix
    ./nix-index.nix
    ./ripgrep.nix
    ./secrets.nix
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
    ollama
    openconnect
    pre-commit
    sd
    tailscale
    wget

    # Languages and tooling
    just
    poetry
    svlint
    typst
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
  
  programs.direnv.enable = true;
  programs.direnv.enableZshIntegration = true;

  programs.helix = {
    enable = true;
    settings = {
      theme = "dracula";
      editor = {
        auto-pairs = false;
        line-number = "relative";
        bufferline = "multiple";
        cursorline = true;
        mouse = false;
        rulers = [70];
        soft-wrap.enable = true;
        soft-wrap.wrap-indicator = "↩ ";
        insert-final-newline = false;
        file-picker.hidden = false;
        # look at auto-save
        # look at whitespace
        # inline-diagnostics
      };
    };
    extraPackages = with pkgs; [
      # bash
      bash-language-server
      # c/cpp (clangd)
      clang-tools
      # cmake
      cmake-language-server
      # docker
      docker-language-server
      docker-compose-language-service
      # html
      superhtml
      # js/ts
      typescript-language-server
      # markdown
      marksman
      # nix
      nil
      # typst
      tinymist
      # yaml
      yaml-language-server
    ];
  };
}
