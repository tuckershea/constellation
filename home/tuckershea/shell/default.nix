{
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    ./atuin
    ./git.nix
    ./jj
    ./neovim.nix
    ./nix-index.nix
    ./ripgrep.nix
    ./secrets.nix
    ./tmux
  ];

  programs.fish = {
    enable = true;
    plugins = with pkgs.fishPlugins; [
      {
        name = "tide";
        inherit (tide) src;
      }
    ];
  };

  home.activation.configure-tide = lib.hm.dag.entryAfter ["writeBoundary"] ''
    ${pkgs.fish}/bin/fish -c "tide configure --auto --style=Rainbow --prompt_colors='16 colors' --show_time=No --rainbow_prompt_separators=Slanted --powerline_prompt_heads=Slanted --powerline_prompt_tails=Slanted --powerline_prompt_style='Two lines, character' --prompt_connection=Solid --powerline_right_prompt_frame=No --prompt_spacing=Compact --icons='Few icons' --transient=No; set tide_character_icon '$'"
  '';

  home = {
    username = "tuckershea";
    homeDirectory = lib.mkDefault "/home/tuckershea"; # fixme
    stateVersion = lib.mkDefault "23.11";

    sessionVariables = {
      EDITOR = "hx";
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
    tree
    wget

    # Languages and tooling
    just
    poetry
    svlint
    typst
    uv
    verilator

    # Helix
    python313Packages.python-lsp-server
    python313Packages.python-lsp-ruff

    beamMinimal28Packages.elixir
    beamMinimal28Packages.elixir-ls
  ];

#  programs.rbenv.enable = true;
#  programs.rbenv.enableFishIntegration = true;
#  programs.rbenv.plugins = 
#        [
#          {
#            name = "ruby-build";
#            src = pkgs.fetchFromGitHub {
#              owner = "rbenv";
#              repo = "ruby-build";
#              rev = "v20250205";
#              hash = "sha256-ZPULUkGkt7FkBTWygiky+QvMJPcslhWw3UPJ6XywfSU=";
#            };
#          }
#        ];
  

  programs.helix = {
    enable = true;
    defaultEditor = true;
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
