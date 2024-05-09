{ pkgs, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      import = [
        "${pkgs.alacritty-theme}/themes/dracula.toml"
      ];

      window.startup_mode = "Fullscreen";
      font.normal.family = "JetBrainsMono Nerd Font Mono";
    };
  };
}
