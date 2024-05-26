{pkgs, ...}: {
  programs.alacritty = {
    enable = true;
    settings = {
      import = [
        "${pkgs.alacritty-theme}/dracula.toml"
      ];

      # Allow for truecolor
      # https://gist.github.com/andersevenrud/015e61af2fd264371032763d4ed965b6
      env.TERM = "xterm-256color";

      window.startup_mode = "Fullscreen";
      font.normal.family = "JetBrainsMono Nerd Font Mono";
    };
  };
}
